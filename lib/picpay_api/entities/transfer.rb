# typed: strict
# frozen_string_literal: true

require 'time'

module PicPayApi
  module Entities
    class Transfer < T::Struct

      extend T::Sig

      # @!attribute transfer_id
      #   @return [String] Transfer Id
      prop :transfer_id, String

      # @!attribute status
      #   @return [String] Transfer status
      prop :status, String

      # @!attribute value
      #   @return [Float] Transfer value
      prop :value, Float

      # @!attribute transfered_at
      #   @return [DateTime] Transfer value
      prop :transfered_at, DateTime

      # @!attribute transaction_id
      #   @return [Integer]
      prop :transaction_id, Integer

      # @!attribute created_at
      #   @return [DateTime] Date of creation of the transfer
      prop :created_at, DateTime

      # @!attribute error
      #   @return [Boolean]
      prop :error, T::Boolean

      # @!attribute operation
      #   @return [String]
      prop :operation, String

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          transfer_id:    @transfer_id,
          status:         @status,
          value:          @value,
          transfered_at:  @transfered_at,
          transaction_id: @transaction_id,
          created_at:     @created_at,
          erro:           @error,
          operacao:       @operation,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::Transfer) }
      def self.from_h(hash:)
        PicPayApi::Entities::Transfer.new(
          transfer_id:    hash[:transfer_id].to_s,
          status:         hash[:status].to_s,
          value:          hash[:value].to_f,
          transfered_at:  DateTime.parse(hash[:transfered_at]),
          transaction_id: hash[:transaction_id].to_i,
          created_at:     DateTime.parse(hash[:created_at]),
          error:          (hash[:erro].to_s.downcase == 'true'),
          operation:      hash[:operacao].to_s,
        )
      end

    end
  end
end
