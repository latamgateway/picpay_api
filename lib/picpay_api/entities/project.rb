# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class Project < T::Struct

      extend T::Sig

      sig { returns(T.nilable(String)) }
      attr_accessor :created_at, :updated_at, :payer_email, :project_id

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
          name:                       T.nilable(String),
          description:                T.nilable(String),
          started_at:                 T.nilable(Date),
          ended_at:                   T.nilable(DateTime),
          withdrawable:               T.nilable(T::Boolean),
          payee_transaction_limit:    Integer,
          payee_transaction_value:    Float,
          identical_transaction_rule: T::Boolean,
          payer_email:                T.nilable(String),
          created_at:                 T.nilable(String),
          updated_at:                 T.nilable(String),
          project_id:                 T.nilable(String),
        ).void
      end
      # @param [nil, String] name (default: nil)
      # Project identifier, visible only to the account that creates the project
      #
      # @param [nil, String] description (default: nil)
      # Project description, visible only to the account that creates the project
      #
      # @param [nil, Date] started_at (default: nil)
      # Start date of payments related to the Credit Referral. If not informed, the rule will not apply
      #
      # @param [nil, DateTime] ended_at (default: nil)
      # Maximum payment date related to Credit Referral. If not informed, the rule will not apply
      # According to the example, requests after 3 pm on 06/01/2021 would not be completed.
      #
      # @param [Boolean] withdrawable (default: true)
      # Defines the balance type:
      #   - If true, the balance will be withdrawable, that is,
      #     the user will be able to transfer the amount to bank account and / or make withdrawals in 24h cashiers
      #   - If the defined value is false the balance will not be withdrawable and the user will
      #     be able to use the balance only within the Picpay application
      #
      # @param [nil, Integer] payee_transaction_limit (default: nil)
      # Total number of transfers allowed for the same CPF. If not informed, the rule will not apply
      #
      # @param [nil, Float] payee_transaction_value (default: nil)
      # Maximum value to be transferred to a given CPF per request. If not informed, the rule will not be applied.
      # For example, a given CPF could receive up to two payments and each payment
      # with a maximum value of R $ 50.25, totaling R $ 100.50.
      #
      # @param [Boolean] identical_transaction_rule (default: true)
      # Defines whether anti-bot validation should be active or not.
      # When enabled, this validation considers all repeated requests for the
      # same CPF to be invalid, with the same value, within two minutes
      #
      # @param [nil, String] payer_email (default: nil)
      # Payer Email - used to map the response
      #
      # @param [nil, String] created_at (default: nil)
      # Created At - used to map the response
      #
      # @param [nil, String] updated_at (default: nil)
      # Updated At - used to map the response
      #
      # @param [nil, String] project_id (default: nil)
      # Project ID - used to map the response
      def initialize(
        name: nil,
        description: nil,
        started_at: nil,
        ended_at: nil,
        withdrawable: true,
        payee_transaction_limit:nil,
        payee_transaction_value:nil,
        identical_transaction_rule:true,
        payer_email: nil,
        created_at: nil,
        updated_at: nil,
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
        @payer_email                = payer_email
        @created_at                 = created_at
        @updated_at                 = updated_at
        @project_id                 = project_id
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        @project_id.nil? ? hash = {} : hash = { project_id: @project_id }

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
          name:                       hash[:name].to_s,
          description:                hash[:description].to_s,
          started_at:                 Date.parse(hash[:started_at].to_s),
          ended_at:                   DateTime.parse(hash[:started_at].to_s),
          withdrawable:               (!!hash[:withdrawable]),
          payee_transaction_limit:    hash[:payee_transaction_limit].to_i,
          payee_transaction_value:    hash[:payee_transaction_value].to_f,
          identical_transaction_rule: (!!hash[:identical_transaction_rule]),
          created_at:                 hash.has_key?('created_at') ? hash[:created_at] : nil,
          updated_at:                 hash.has_key?('updated_at') ? hash[:updated_at] : nil,
          payer_email:                hash.has_key?('payer_email') ? hash[:payer_email] : nil,
          project_id:                 hash.has_key?('project_id') ? hash[:project_id] : nil,
        )
      end

    end
  end
end
