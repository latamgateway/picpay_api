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
