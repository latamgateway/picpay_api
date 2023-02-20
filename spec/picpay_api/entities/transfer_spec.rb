# typed: false
# frozen_string_literal: true

require 'time'

RSpec.describe PicPayApi::Entities::Transfer do
  describe 'Object' do

    let!(:transfer_id) { ENV['PICPAY_TRANSFER_ID'].to_s }
    let!(:status) { ENV['PICPAY_TRANSFER_STATUS'] }
    let!(:value) { ENV['PICPAY_TRANSFER_VALUE'].to_f }
    let!(:transfered_at) { DateTime.parse(ENV['PICPAY_TRANSFER_TRANSFERED_AT']) }
    let!(:transaction_id) { ENV['PICPAY_TRANSFER_TRANSACTION_ID'].to_i }
    let!(:created_at) { DateTime.parse(ENV['PICPAY_TRANSFER_CREATED_AT']) }
    let!(:erro) { !!ENV['PICPAY_TRANSFER_ERRO'] }
    let!(:operacao) { ENV['PICPAY_TRANSFER_OPERACAO'] }

    context 'attributes' do
      it 'has attr_accessors' do
        transfer = described_class.new(
          transfer_id:    transfer_id,
          status:         status,
          value:          value.to_f,
          transfered_at:  transfered_at,
          transaction_id: transaction_id,
          created_at:     created_at,
          erro:           erro,
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
          value:          value,
          transfered_at:  transfered_at,
          transaction_id: transaction_id,
          created_at:     created_at,
          erro:           erro,
          operacao:       operacao
        )

        expect(transfer.transfer_id).to eq(transfer_id)
        expect(transfer.status).to eq(status)
        expect(transfer.value).to eq(value)
        expect(transfer.transfered_at).to eq(transfered_at)
        expect(transfer.transaction_id).to eq(transaction_id)
        expect(transfer.created_at).to eq(created_at)
        expect(transfer.erro).to eq(erro)
        expect(transfer.operacao).to eq(operacao)
      end
    end
  end
end
