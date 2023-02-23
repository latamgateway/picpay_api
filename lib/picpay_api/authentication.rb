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
    # @param [String] base_url Picpay API base URL.
    # @param [String] client_id CLIENT_ID sent by Picpay.
    # @param [String] client_secret CLIENT_SECRET sent by Picpay
    def initialize(
      base_url:,
      client_id:,
      client_secret:,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      @url           = T.let(URI.join(base_url, '/oauth2/token'), URI::Generic)
      @client_id     = client_id
      @client_secret = client_secret
    end

    sig { returns(PicPayApi::Entities::AuthenticationResponse) }
    # Use this address to generate the authorization token that must be sent in the header of other requests.
    # It is necessary to use the CLIENT_ID and CLIENT_SECRET defined in the credential provided by PicPay.
    # Each authorization token generated will have the validity of 5 ( five ) minutes,
    # requiring a request for a new token.
    def token_request
      token_request = PicPayApi::Entities::TokenRequest.new(
        client_id:     @client_id,
        client_secret: @client_secret
      )

      body = PicPayApi::HTTP::Client.post(uri: @url, payload: token_request.to_h)
      PicPayApi::Entities::AuthenticationResponse.from_h(body)
    end

    sig { params(refresh_token: String).returns(PicPayApi::Entities::AuthenticationResponse) }
    # We recommend generating a new token only when the previous one expires,
    # since the creation of a new token invalidates the previous one
    # and this can result in a competition problem between requests.
    #
    # To update the token just change the value of the grant_type parameter to "refresh_token"
    # and add the field refresh_token such as that received in response to the first request.
    #
    # @param [String] refresh_token Received after requesting an "access token"
    def refresh_token_request(refresh_token:)
      refresh_token_request = PicPayApi::Entities::RefreshTokenRequest.new(
        client_id:     @client_id,
        client_secret: @client_secret,
        refresh_token: refresh_token
      )

      body = PicPayApi::HTTP::Client.post(uri: @url, payload: refresh_token_request.to_h)
      PicPayApi::Entities::AuthenticationResponse.from_h(body)
    end

  end
end
