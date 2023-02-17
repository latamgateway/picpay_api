# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class TokenRequest < T::Struct

      extend T::Sig

      SCOPE      = 'openid b2p.transfer'.freeze
      GRANT_TYPE = 'client_credentials'.freeze

      # @!attribute client_id
      #   @return [String]
      # CLIENT_ID sent by Picpay.
      prop :client_id, String

      # @!attribute client_secret
      #   @return [String]
      # CLIENT_SECRET sent by Picpay
      prop :client_secret, String

      # @!attribute grant_type
      #   @return [String]
      # Inform "client_credentials".
      prop :grant_type, String, default: GRANT_TYPE

      # @!attribute scope
      #   @return [String]
      # scope By default, inform "openid b2p.transfer"
      prop :scope, String, default: GRANT_TYPE

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
