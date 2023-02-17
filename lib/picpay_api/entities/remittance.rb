# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Remittance < T::Struct

      extend T::Sig

      sig { returns(Float) }
      attr_accessor :value

      sig { returns(String) }
      attr_accessor :consumer, :reference_id

      sig do
        params(
          consumer:     String,
          value:        Float,
          reference_id: String,
        ).void
      end
      # This feature creates a transfer request, comparing the received values with the previously defined rules.
      # The transfer is completed only if the data is in accordance with the Project settings.
      #
      # @param [String] consumer
      # CPF of the PicPay user who will receive the transfer
      #
      # @param [Float] value
      # Value to be transferred to the user
      #
      # @param [String] reference_id
      # Unique identifier of your order. This field must always be unique.
      # This will also be the ID your store will use to view payment status.
      def initialize(
        consumer:,
        value:,
        reference_id:
      )
        @consumer     = consumer
        @value        = value
        @reference_id = reference_id
      end

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
          reference_id: hash[:reference_id],
        )
      end

    end
  end
end
