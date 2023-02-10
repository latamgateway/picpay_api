# typed: strict
# frozen_string_literal: true

require 'logger'

module PicPayApi
  class Authentication

    extend T::Sig

    sig { returns(Logger) }
    attr_accessor :logger

    sig { returns(String) }
    attr_accessor :client_id, :client_secret, :scope

    sig { returns(URI::Generic) }
    attr_accessor :auth_url

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
      @auth_url      = T.let(
        URI.join(base_url, '/oauth2/token'), URI::Generic
      # URI.join('https://enw735b71j6xp.x.pipedream.net'), URI::Generic
      )
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

      response = PicPayApi::HTTP::Client.post!(@auth_url, payload)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      unless response.is_a?(Net::HTTPSuccess)
        raise PicPayApi::Errors::Unauthorized, body[:error_description]
      end

      body
    end

    def refresh_token_request
      payload = {
        "grant_type":    GRAND_TYPE[:refresh_token],
        "scope":         @scope,
        "client_id":     @client_id,
        "client_secret": @client_secret,
        "refresh_token": "eyJhbGciOiJIUzI1NVCJ9.eyJkYXRhIjoidmFsdWUifQ.78pp6_Dx5L0fz-xkpUEbZI"
      }

      PicPayApi::HTTP::Client.post!(@auth_url, payload)

    end

  end
end
