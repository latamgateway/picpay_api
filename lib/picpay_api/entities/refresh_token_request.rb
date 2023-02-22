# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class RefreshTokenRequest < T::Struct

      extend T::Sig

      GRANT_TYPE = T.let('refresh_token'.freeze, String)

      # @!attribute client_id
      #   @return [String]
      #   CLIENT_ID sent by Picpay.
      prop :client_id, String

      # @!attribute client_secret
      #   @return [String]
      #   CLIENT_SECRET sent by Picpay
      prop :client_secret, String

      # @!attribute refresh_token
      #   @return [String]
      #   Received after requesting an "access token"
      prop :refresh_token, String

      # @!attribute grant_type
      #   @return [String]
      #   Inform "refresh_token".
      prop :grant_type, String, default: GRANT_TYPE

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          grant_type:    @grant_type,
          client_id:     @client_id,
          client_secret: @client_secret,
          refresh_token: @refresh_token,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::RefreshTokenRequest) }
      def self.from_h(hash:)
        PicPayApi::Entities::RefreshTokenRequest.new(
          client_id:     hash[:client_id].to_s,
          client_secret: hash[:client_secret].to_s,
          refresh_token: hash[:refresh_token].to_s,
          grant_type:    hash.fetch(:grant_type, GRANT_TYPE).to_s,
        )
      end

    end
  end
end
