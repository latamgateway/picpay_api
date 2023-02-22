# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Remittance < T::Struct

      extend T::Sig

      # @!attribute consumer
      #   @return [String]
      #   CPF of the PicPay user who will receive the transfer
      prop :consumer, String

      # @!attribute value
      #   @return [Float]
      #   Value to be transferred to the user
      prop :value, Float

      # @!attribute reference_id
      #   @return [String]
      #   Unique identifier of your order. This field must always be unique.
      #   This will also be the ID your store will use to view payment status.
      prop :reference_id, String

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          consumer:     @consumer,
          value:        @value,
          reference_id: @reference_id,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::Remittance) }
      def self.from_h(hash:)
        PicPayApi::Entities::Remittance.new(
          consumer:     hash[:consumer].to_s,
          value:        hash[:value].to_f,
          reference_id: hash[:reference_id].to_s,
        )
      end

    end
  end
end
