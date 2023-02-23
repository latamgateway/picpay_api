# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class TokenRequest < T::Struct

      extend T::Sig

      GRANT_TYPE = T.let('client_credentials'.freeze, String)
      SCOPE      = T.let('openid b2p.transfer'.freeze, String)

      # @!attribute client_id
      #   @return [String]
      #   CLIENT_ID sent by Picpay.
      prop :client_id, String

      # @!attribute client_secret
      #   @return [String]
      #   CLIENT_SECRET sent by Picpay
      prop :client_secret, String

      # @!attribute grant_type
      #   @return [String]
      #   Inform "client_credentials".
      prop :grant_type, String, default: GRANT_TYPE

      # @!attribute scope
      #   @return [String]
      #   scope By default, inform "openid b2p.transfer"
      prop :scope, String, default: SCOPE

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          grant_type:    @grant_type,
          scope:         @scope,
          client_id:     @client_id,
          client_secret: @client_secret,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::TokenRequest) }
      def self.from_h(hash)
        PicPayApi::Entities::TokenRequest.new(
          client_id:     hash[:client_id].to_s,
          client_secret: hash[:client_secret].to_s,
          grant_type:    hash.fetch(:grant_type, GRANT_TYPE).to_s,
          scope:         hash.fetch(:scope, SCOPE).to_s,
        )
      end

    end
  end
end
