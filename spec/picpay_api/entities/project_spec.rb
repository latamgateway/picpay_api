# typed: false
# frozen_string_literal: true

require 'time'

RSpec.describe PicPayApi::Entities::Project do
  describe 'Object' do

    let!(:name) { 'Lorem ipsum' }
    let!(:description) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit' }
    let!(:started_at) { '2021-01-01' }
    let!(:ended_at) { '2021-01-01' }
    let!(:withdrawable) { true }
    let!(:payee_transaction_limit) { 2 }
    let!(:payee_transaction_value) { 50.25 }
    let!(:identical_transaction_rule) { false }

    context 'attributes' do
      it 'has attr_accessors' do
        project = described_class.new(
          name:                       name,
          description:                description,
          started_at:                 Date.parse(started_at),
          ended_at:                   DateTime.parse(started_at),
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
          started_at:                 Date.parse(started_at),
          ended_at:                   DateTime.parse(started_at),
          withdrawable:               withdrawable,
          payee_transaction_limit:    payee_transaction_limit,
          payee_transaction_value:    payee_transaction_value,
          identical_transaction_rule: identical_transaction_rule,
        )

        expect(project.name).to eq(name)
        expect(project.description).to eq(description)
        expect(project.started_at).to eq(Date.parse(started_at))
        expect(project.ended_at).to eq(DateTime.parse(ended_at))
        expect(project.withdrawable).to eq(withdrawable)
        expect(project.payee_transaction_limit).to eq(payee_transaction_limit)
        expect(project.payee_transaction_value).to eq(payee_transaction_value)
        expect(project.identical_transaction_rule).to eq(identical_transaction_rule)
      end
    end
  end
end
