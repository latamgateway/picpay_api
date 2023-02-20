# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Authorization < T::Struct

      extend T::Sig

      TYPES = {
        bearer: 'Bearer',
      }.freeze

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

      def to_s
        "#{TYPES[@type.to_sym]}\s#{@token}"
      end

    end
  end
end
