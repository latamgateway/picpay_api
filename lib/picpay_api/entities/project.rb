# typed: strict
# frozen_string_literal: true

require 'time'

module PicPayApi
  module Entities
    class Project < T::Struct

      extend T::Sig

      # @!attribute name
      #   @return [nil, String] (default: nil)
      # Project identifier, visible only to the account that creates the project
      prop :name, T.nilable(String), default: nil

      # @!attribute description
      #   @return [nil, String] (default: nil)
      # Project description, visible only to the account that creates the project
      prop :description, T.nilable(String), default: nil

      # @!attribute started_at (default: nil)
      #   @return [nil, Date] (default: nil)
      # Start date of payments related to the Credit Referral. If not informed, the rule will not apply
      prop :started_at, T.nilable(Date), default: nil

      # @!attribute ended_at
      #   @return [nil, DateTime] (default: nil)
      # Maximum payment date related to Credit Referral. If not informed, the rule will not apply
      # According to the example, requests after 3 pm on 06/01/2021 would not be completed.
      prop :ended_at, T.nilable(DateTime), default: nil

      # @!attribute withdrawable
      #   @return [Boolean] (default: true)
      # Defines the balance type:
      #   - If true, the balance will be withdrawable, that is,
      #     the user will be able to transfer the amount to bank account and / or make withdrawals in 24h cashiers
      #   - If the defined value is false the balance will not be withdrawable and the user will
      #     be able to use the balance only within the Picpay application
      prop :withdrawable, T.nilable(T::Boolean), default: nil

      # @!attribute payee_transaction_limit
      #   @return [nil, Integer] (default: nil)
      # Total number of transfers allowed for the same CPF. If not informed, the rule will not apply
      prop :payee_transaction_limit, T.nilable(Integer), default: nil

      # @!attribute payee_transaction_value
      #   @return [nil, Float] (default: nil)
      # Maximum value to be transferred to a given CPF per request. If not informed, the rule will not be applied.
      # For example, a given CPF could receive up to two payments and each payment
      # with a maximum value of R $ 50.25, totaling R $ 100.50.
      prop :payee_transaction_value, T.nilable(Float), default: nil

      # @!attribute identical_transaction_rule
      #   @return [Boolean] (default: true)
      # Defines whether anti-bot validation should be active or not.
      # When enabled, this validation considers all repeated requests for the
      # same CPF to be invalid, with the same value, within two minutes
      prop :identical_transaction_rule, T.nilable(T::Boolean), default: nil

      # @!attribute payer_email (default: nil)
      #   @return [nil, String] (default: nil)
      # Payer Email - used to map the response
      prop :payer_email, T.nilable(String), default: nil

      # @!attribute created_at
      #   @return [nil, String] (default: nil)
      # Created At - used to map the response
      prop :created_at, T.nilable(String), default: nil

      # @!attribute updated_at
      #   @return [nil, String] (default: nil)
      # Updated At - used to map the response
      prop :updated_at, T.nilable(String), default: nil

      # @!attribute project_id
      #   @return [nil, String] (default: nil)
      # Project ID - used to map the response
      prop :project_id, T.nilable(String), default: nil

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
          created_at:                 hash.fetch(:created_at, nil),
          updated_at:                 hash.fetch(:updated_at, nil),
          payer_email:                hash.fetch(:payer_email, nil),
          project_id:                 hash.fetch(:project_id, nil),
        )
      end

    end
  end
end
