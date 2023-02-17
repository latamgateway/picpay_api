# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class RefreshTokenRequest

      extend T::Sig

      GRANT_TYPE = 'refresh_token'.freeze

      sig { returns(String) }
      attr_accessor :grant_type, :client_id, :client_secret, :refresh_token

      # include PicPayApi::Entities::TokenRequestErrorable

      sig do
        params(
          client_id:     String,
          client_secret: String,
          refresh_token: String,
          grant_type:    String,
        ).void
      end
      # We recommend generating a new token only when the previous one expires,
      # since the creation of a new token invalidates the previous one
      # and this can result in a competition problem between requests.
      #
      # To update the token just change the value of the grant_type parameter to "refresh_token"
      # and add the field refresh_token such as that received in response to the first request.
      #
      # @param [String] client_id CLIENT_ID sent by Picpay.
      # @param [String] client_secret CLIENT_SECRET sent by Picpay
      # @param [String] refresh_token Received after requesting an "access token"
      # @param [String] grant_type Inform "refresh_token".
      def initialize(
        client_id:,
        client_secret:,
        refresh_token:,
        grant_type: GRANT_TYPE
      )
        @grant_type    = grant_type
        @client_id     = client_id
        @client_secret = client_secret
        @refresh_token = refresh_token
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          grant_type:    @grant_type,
          client_id:     @client_id,
          client_secret: @client_secret,
          refresh_token: @refresh_token,
        }
      end

    end
  end
end
