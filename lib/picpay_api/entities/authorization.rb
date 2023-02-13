# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Authorization

      extend T::Sig

      TYPE = {
        bearer: 'Bearer',
      }

      sig { returns(String) }
      attr_accessor :type, :token

      sig do
        params(
          type:  String,
          token: String,
        ).void
      end
      def initialize(
        type:,
        token:
      )
        @token = token
        @type  = type
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          token: @token,
          type:  @type,
        }
      end

    end
  end
end
