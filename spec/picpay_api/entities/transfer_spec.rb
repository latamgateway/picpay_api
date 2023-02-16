# typed: false
# frozen_string_literal: true

require 'time'
require 'bigdecimal'

RSpec.describe PicPayApi::Entities::Transfer do
  describe 'Object' do

    let!(:transfer_id) { '620a8ff3b5670c4a4149049d' }
    let!(:status) { 'SUCCEEDED' }
    let!(:value) { 0.01 }
    let!(:transfered_at) { '2022-02-14T17:23:02.647000Z' }
    let!(:transaction_id) { 249344 }
    let!(:created_at) { '2022-02-14T17:23:02.647000Z' }
    let!(:erro) { false }
    let!(:operacao) { 'transferencia' }

    context 'attributes' do
      it 'has attr_accessors' do
        transfer = described_class.new(
          transfer_id:    transfer_id,
          status:         status,
          value:          value.to_f,
          transfered_at:  DateTime.parse(transfered_at),
          transaction_id: transaction_id,
          created_at:     DateTime.parse(created_at),
          erro:           (!!erro),
          operacao:       operacao
        )

        expect(transfer).to respond_to(:transfer_id)
        expect(transfer).to respond_to(:status)
        expect(transfer).to respond_to(:value)
        expect(transfer).to respond_to(:transfered_at)
        expect(transfer).to respond_to(:transaction_id)
        expect(transfer).to respond_to(:created_at)
        expect(transfer).to respond_to(:erro)
        expect(transfer).to respond_to(:operacao)

        expect(transfer).to respond_to(:transfer_id=)
        expect(transfer).to respond_to(:status=)
        expect(transfer).to respond_to(:value=)
        expect(transfer).to respond_to(:transfered_at=)
        expect(transfer).to respond_to(:transaction_id=)
        expect(transfer).to respond_to(:created_at=)
        expect(transfer).to respond_to(:erro=)
        expect(transfer).to respond_to(:operacao=)

      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        transfer = described_class.new(
          transfer_id:    transfer_id,
          status:         status,
          value:          value.to_f,
          transfered_at:  DateTime.parse(transfered_at),
          transaction_id: transaction_id,
          created_at:     DateTime.parse(created_at),
          erro:           (!!erro),
          operacao:       operacao
        )

        expect(transfer.transfer_id).to eq(transfer_id)
        expect(transfer.status).to eq(status)
        expect(transfer.value).to eq(value.to_f)
        expect(transfer.transfered_at).to eq(DateTime.parse(transfered_at))
        expect(transfer.transaction_id).to eq(transaction_id)
        expect(transfer.created_at).to eq(DateTime.parse(created_at))
        expect(transfer.erro).to eq(!!erro)
        expect(transfer.operacao).to eq(operacao)
      end
    end
  end
end
