# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Project

      extend T::Sig

      sig { returns(Integer) }
      attr_accessor :payee_transaction_limit

      sig { returns(Float) }
      attr_accessor :payee_transaction_value

      sig { returns(String) }
      attr_accessor :name, :description

      sig { returns(Date) }
      attr_accessor :started_at

      sig { returns(DateTime) }
      attr_accessor :ended_at

      sig { returns(T::Boolean) }
      attr_accessor :withdrawable, :identical_transaction_rule

      sig do
        params(
          name:                       String,
          description:                String,
          started_at:                 Date,
          ended_at:                   DateTime,
          withdrawable:               T::Boolean,
          payee_transaction_limit:    Integer,
          payee_transaction_value:    Float,
          identical_transaction_rule: T::Boolean,
        ).void
      end
      def initialize(
        name:,
        description:,
        started_at:,
        ended_at:,
        withdrawable:,
        payee_transaction_limit:,
        payee_transaction_value:,
        identical_transaction_rule:
      )
        @name                       = name
        @description                = description
        @started_at                 = started_at
        @ended_at                   = ended_at
        @withdrawable               = withdrawable
        @payee_transaction_limit    = payee_transaction_limit
        @payee_transaction_value    = payee_transaction_value
        @identical_transaction_rule = identical_transaction_rule
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          name:                       @name,
          description:                @description,
          started_at:                 @started_at,
          ended_at:                   @ended_at,
          withdrawable:               @withdrawable,
          payee_transaction_limit:    @payee_transaction_limit,
          payee_transaction_value:    @payee_transaction_value,
          identical_transaction_rule: @identical_transaction_rule,
        }
      end

    end
  end
end
