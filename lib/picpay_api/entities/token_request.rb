# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class TokenRequest

      extend T::Sig

      SCOPE      = 'openid b2p.transfer'.freeze
      GRANT_TYPE = 'client_credentials'.freeze

      sig { returns(String) }
      attr_accessor :client_id, :client_secret, :grant_type, :scope

      #include PicPayApi::Entities::TokenRequestErrorable

      sig do
        params(
          client_id:     String,
          client_secret: String,
          grant_type:    String,
          scope:         String,
        ).void
      end
      # Use this address to generate the authorization token that must be sent in the header of other requests.
      # It is necessary to use the CLIENT_ID and CLIENT_SECRET defined in the credential provided by PicPay.
      # Each authorization token generated will have the validity of 5 ( five ) minutes,
      # requiring a request for a new token.
      #
      # @param [String] client_id CLIENT_ID sent by Picpay.
      # @param [String] client_secret CLIENT_SECRET sent by Picpay
      # @param [String] grant_type Inform "client_credentials".
      # @param [String] scope By default, inform "openid b2p.transfer"
      def initialize(
        client_id:,
        client_secret:,
        grant_type: GRANT_TYPE,
        scope: SCOPE
      )
        @client_id     = client_id
        @client_secret = client_secret
        @grant_type    = grant_type
        @scope         = scope
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          grant_type:    @grant_type,
          scope:         @scope,
          client_id:     @client_id,
          client_secret: @client_secret,
        }
      end

    end
  end
end
