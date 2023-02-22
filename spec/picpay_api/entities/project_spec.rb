# typed: false
# frozen_string_literal: true

require 'time'

RSpec.describe PicPayApi::Entities::Project do
  describe 'Object' do

    let!(:name) { ENV['PICPAY_PROJECT_NAME'].to_s }
    let!(:description) { ENV['PICPAY_PROJECT_DESCRIPTION'].to_s }
    let!(:started_at) { Date.parse(ENV['PICPAY_PROJECT_STARTED_AT']) }
    let!(:ended_at) { DateTime.parse(ENV['PICPAY_PROJECT_ENDED_AT']) }
    let!(:withdrawable) { (ENV['PICPAY_PROJECT_WITHDRAWABLE'].to_s.downcase == 'true') }
    let!(:payee_transaction_limit) { ENV['PICPAY_PROJECT_PAYEE_TRANSACTION_LIMIT'].to_i }
    let!(:payee_transaction_value) { ENV['PICPAY_PROJECT_PAYEE_TRANSACTION_VALUE'].to_f }
    let!(:identical_transaction_rule) { (ENV['PICPAY_PROJECT_IDENTICAL_TRANSACTION_RULE'].to_s.downcase == 'true') }

    context 'attributes' do
      it 'has attr_accessors' do
        project = described_class.new(
          name:                       name,
          description:                description,
          started_at:                 started_at,
          ended_at:                   ended_at,
          withdrawable:               withdrawable,
          payee_transaction_limit:    payee_transaction_limit,
          payee_transaction_value:    payee_transaction_value,
          identical_transaction_rule: identical_transaction_rule,
        )

        expect(project).to respond_to(:name)
        expect(project).to respond_to(:description)
        expect(project).to respond_to(:started_at)
        expect(project).to respond_to(:ended_at)
        expect(project).to respond_to(:withdrawable)
        expect(project).to respond_to(:payee_transaction_limit)
        expect(project).to respond_to(:payee_transaction_value)
        expect(project).to respond_to(:identical_transaction_rule)

        expect(project).to respond_to(:name=)
        expect(project).to respond_to(:description=)
        expect(project).to respond_to(:started_at=)
        expect(project).to respond_to(:ended_at=)
        expect(project).to respond_to(:withdrawable=)
        expect(project).to respond_to(:payee_transaction_limit=)
        expect(project).to respond_to(:payee_transaction_value=)
        expect(project).to respond_to(:identical_transaction_rule=)

      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        project = described_class.new(
          name:                       name,
          description:                description,
          started_at:                 started_at,
          ended_at:                   ended_at,
          withdrawable:               withdrawable,
          payee_transaction_limit:    payee_transaction_limit,
          payee_transaction_value:    payee_transaction_value,
          identical_transaction_rule: identical_transaction_rule,
        )

        expect(project.name).to eq(name)
        expect(project.description).to eq(description)
        expect(project.started_at).to eq(started_at)
        expect(project.ended_at).to eq(ended_at)
        expect(project.withdrawable).to eq(withdrawable)
        expect(project.payee_transaction_limit).to eq(payee_transaction_limit)
        expect(project.payee_transaction_value).to eq(payee_transaction_value)
        expect(project.identical_transaction_rule).to eq(identical_transaction_rule)
      end
    end
  end
end
