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
