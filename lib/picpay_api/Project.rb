# typed: strict
# frozen_string_literal: true

require 'logger'

#
# {
#   "name": "Lorem ipsum",
#   "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
#   "started_at": "2021-01-01",
#   "ended_at": "2021-06-01 15:00",
#   "withdrawable": true,
#   "payee_transaction_limit": 2,
#   "payee_transaction_value": 50.25,
#   "identical_transaction_rule": false
# }

module PicPayApi
  class Project

    extend T::Sig

    sig { returns(Logger) }
    attr_accessor :logger

    sig { returns(String) }
    attr_accessor :client_id, :client_secret, :scope

    sig { returns(URI::Generic) }
    attr_accessor :url

    SCOPE = 'openid b2p.transfer'.freeze

    GRAND_TYPE = {
      token_request:         'client_credentials',
      refresh_token_request: 'refresh_token',
    }.freeze

    sig do
      params(
        base_url:      String,
        client_id:     String,
        client_secret: String,
        scope:         String,
        logger:        Logger
      ).void
    end
    def initialize(
      base_url:,
      client_id:,
      client_secret:,
      scope: SCOPE,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      @url           = T.let(URI.join(base_url, '/b2p/v2/projects'), URI::Generic)
      @client_id     = client_id
      @client_secret = client_secret
      @scope         = scope
    end

    def token_request
      payload = {
        "grant_type":    GRAND_TYPE[:token_request],
        "scope":         @scope,
        "client_id":     @client_id,
        "client_secret": @client_secret,
      }

      response = PicPayApi::HTTP::Client.post!(@url, payload)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      unless response.is_a?(Net::HTTPSuccess)
        raise PicPayApi::Errors::Authentication, body[:error_description]
      end

      body
    end

    def refresh_token_request(refresh_token:)
      payload = {
        "grant_type":    GRAND_TYPE[:refresh_token_request],
        "client_id":     @client_id,
        "client_secret": @client_secret,
        "refresh_token": refresh_token,
      }

      response = PicPayApi::HTTP::Client.post!(@url, payload)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      unless response.is_a?(Net::HTTPSuccess)
        raise PicPayApi::Errors::Authentication, body[:error_description]
      end

      body

    end

  end
end
