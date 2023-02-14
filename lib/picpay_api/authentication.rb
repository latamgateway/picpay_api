# typed: strict
# frozen_string_literal: true

require 'logger'

module PicPayApi
  class Authentication

    extend T::Sig

    sig { returns(Logger) }
    attr_accessor :logger

    sig { returns(String) }
    attr_accessor :client_id, :client_secret

    sig { returns(URI::Generic) }
    attr_accessor :url

    sig do
      params(
        base_url:      String,
        client_id:     String,
        client_secret: String,
        logger:        Logger
      ).void
    end
    def initialize(
      base_url:,
      client_id:,
      client_secret:,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      base_url       = base_url.chop if base_url[-1] === '/'
      @url           = T.let(URI.join(base_url, '/oauth2/token'), URI::Generic)
      @client_id     = client_id
      @client_secret = client_secret

    end

    sig { returns(T.untyped) }
    def token_request
      token_request = PicPayApi::Entities::TokenRequest.new(
        client_id:     @client_id,
        client_secret: @client_secret
      )
      request!(entity: token_request)
    end

    sig { params(refresh_token: String).returns(T.untyped) }
    def refresh_token_request(refresh_token:)
      refresh_token_request = PicPayApi::Entities::RefreshTokenRequest.new(
        client_id:     @client_id,
        client_secret: @client_secret,
        refresh_token: refresh_token
      )
      request!(entity: refresh_token_request)
    end

    private

    def request!(entity:)
      response = PicPayApi::HTTP::Client.post!(uri: @url, payload: entity.to_h)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])


      puts response.inspect


      unless response.is_a?(Net::HTTPSuccess)
        raise PicPayApi::Errors::Authentication, body[:error_description]
      end

      body
    end

  end
end
