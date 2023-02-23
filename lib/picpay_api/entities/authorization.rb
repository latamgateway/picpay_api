# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Authorization < T::Struct

      extend T::Sig

      TYPES = T.let({
        bearer: 'Bearer',
      }.freeze, T::Hash[Symbol, String])

      # @!attribute type
      #   @return [String]
      prop :type, String

      # @!attribute token
      #   @return [String]
      prop :token, String

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          token: @token,
          type:  @type,
        }
      end

      sig { returns(String) }
      def to_s
        "#{TYPES[@type.to_sym]}\s#{@token}"
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::Authorization) }
      def self.from_h(hash)
        PicPayApi::Entities::Authorization.new(type: hash[:token_type].to_s, token: hash[:access_token].to_s)
      end

      sig { params(response: PicPayApi::Entities::AuthenticationResponse).returns(PicPayApi::Entities::Authorization) }
      def from_response(response)
        PicPayApi::Entities::Authorization.new(type: response.token_type.to_s, token: response.access_token.to_s)
      end

    end
  end
end
