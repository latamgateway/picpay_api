# typed: strict
# frozen_string_literal: true

require 'time'

module PicPayApi
  module Entities
    class Transfer < T::Struct

      extend T::Sig

      sig { returns(Float) }
      attr_accessor :value

      sig { returns(Integer) }
      attr_accessor :transaction_id

      sig { returns(String) }
      attr_accessor :transfer_id, :status, :operacao

      sig { returns(DateTime) }
      attr_accessor :created_at, :transfered_at

      sig { returns(T::Boolean) }
      attr_accessor :erro

      sig do
        params(
          transfer_id:    String,
          status:         String,
          value:          Float,
          transfered_at:  DateTime,
          transaction_id: Integer,
          created_at:     DateTime,
          erro:           T::Boolean,
          operacao:       String,
        ).void
      end
      # Registering the Project is a required step for the Credit Referral flow.
      # It contains all the settings that must be applied to the Shipping.
      #
      # @param [String] transfer_id Transfer Id
      # @param [String] status Transfer status
      # @param [Float] value Transfer value
      # @param [DateTime] transfered_at
      # @param [Integer] transaction_id
      # @param [DateTime] created_at date of creation of the transfer
      # @param [Boolean] erro
      # @param [String] operacao
      def initialize(
        transfer_id:,
        status:,
        value:,
        transfered_at:,
        transaction_id:,
        created_at:,
        erro:,
        operacao:
      )
        @transfer_id    = transfer_id
        @status         = status
        @value          = value
        @transfered_at  = transfered_at
        @transaction_id = transaction_id
        @created_at     = created_at
        @erro           = erro
        @operacao       = operacao
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          transfer_id:    @transfer_id,
          status:         @status,
          value:          @value,
          transfered_at:  @transfered_at,
          transaction_id: @transaction_id,
          created_at:     @created_at,
          erro:           @erro,
          operacao:       @operacao,
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
          erro:           (!!hash[:erro]),
          operacao:       hash[:operacao].to_s
        )
      end

    end
  end
end
