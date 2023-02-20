# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class AuthenticationResponse < T::Struct

      extend T::Sig

      # @!attribute access_token
      #   @return [String]
      prop :access_token, String

      # @!attribute expires_in
      #   @return [Integer]
      prop :expires_in, Integer

      # @!attribute refresh_expires_in
      #   @return [Integer]
      prop :refresh_expires_in, Integer

      # @!attribute refresh_token
      #   @return [String]
      prop :refresh_token, String

      # @!attribute token_type
      #   @return [String]
      prop :token_type, String

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          access_token:       @access_token,
          expires_in:         @expires_in,
          refresh_expires_in: @refresh_expires_in,
          refresh_token:      @refresh_token,
          token_type:         @token_type,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::AuthenticationResponse) }
      def self.from_h(hash:)
        PicPayApi::Entities::AuthenticationResponse.new(
          access_token:       hash[:access_token],
          expires_in:         hash[:expires_in].to_i,
          refresh_expires_in: hash[:refresh_expires_in].to_i,
          refresh_token:      hash[:refresh_token],
          token_type:         hash[:token_type],
        )
      end

    end
  end
end
