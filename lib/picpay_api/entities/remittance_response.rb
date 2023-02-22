# typed: strict
# frozen_string_literal: true

require 'time'

module PicPayApi
  module Entities
    class RemittanceResponse < T::Struct

      extend T::Sig

      # @!attribute transfer_id
      #   @return [String]
      #   Transfer identifier
      prop :transfer_id, String

      # @!attribute reference_id
      #   @return [String]
      #   Unique identifier of your order. This field must always be unique.
      #   This will also be the ID your store will use to view payment status.
      prop :reference_id, String

      # @!attribute value
      #   @return [DateTime]
      #   Unique identifier of your order.
      prop :created_at, DateTime

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          transfer_id:  @transfer_id,
          reference_id: @reference_id,
          created_at:   @created_at,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::RemittanceResponse) }
      def self.from_h(hash:)
        PicPayApi::Entities::RemittanceResponse.new(
          transfer_id:  hash[:transfer_id].to_s,
          reference_id: hash[:reference_id].to_s,
          created_at:   DateTime.parse(hash[:created_at]),
        )
      end

    end
  end
end
