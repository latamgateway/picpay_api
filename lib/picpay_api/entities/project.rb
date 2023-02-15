# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Project < T::Struct

      extend T::Sig

      sig { returns(T.nilable(String)) }
      attr_accessor :project_id

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
          project_id:                 T.nilable(String),
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
        identical_transaction_rule:,
        project_id: nil
      )
        @name                       = name
        @description                = description
        @started_at                 = started_at
        @ended_at                   = ended_at
        @withdrawable               = withdrawable
        @payee_transaction_limit    = payee_transaction_limit
        @payee_transaction_value    = payee_transaction_value
        @identical_transaction_rule = identical_transaction_rule
        @project_id                 = project_id
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        hash = { project_id: @project_id } unless @project_id.nil?

        hash.merge!({
          name:                       @name,
          description:                @description,
          started_at:                 @started_at,
          ended_at:                   @ended_at,
          withdrawable:               @withdrawable,
          payee_transaction_limit:    @payee_transaction_limit,
          payee_transaction_value:    @payee_transaction_value,
          identical_transaction_rule: @identical_transaction_rule,
        })
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::Project) }
      def self.from_h(hash:)
        PicPayApi::Entities::Project.new(
          name:                       hash[:name],
          description:                hash[:description],
          started_at:                 Date.parse(hash[:started_at]),
          ended_at:                   DateTime.parse(hash[:started_at]),
          withdrawable:               (!!hash[:withdrawable]),
          payee_transaction_limit:    hash[:payee_transaction_limit].to_i,
          payee_transaction_value:    hash[:payee_transaction_value].to_f,
          identical_transaction_rule: (!!hash[:identical_transaction_rule]),
          project_id:                 hash.has_key?('project_id') ? hash[:project_id] : nil,
        )
      end

    end
  end
end
