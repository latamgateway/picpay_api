# typed: false
# frozen_string_literal: true

require 'time'

FactoryBot.define do
  factory :transfer, class: PicPayApi::Entities::Transfer do
    transfer_id { ENV['TRANSFER_ID'] }
    status { ENV['TRANSFER_STATUS'] }
    value { ENV['TRANSFER_VALUE'] }
    transfered_at { ENV['TRANSFER_TRANSFERED_AT'] }
    transaction_id { ENV['TRANSFER_TRANSACTION_ID'] }
    created_at { ENV['TRANSFER_CREATED_AT'] }
    erro { ENV['TRANSFER_ERRO'] }
    operacao { ENV['TRANSFER_OPERACAO'] }

    initialize_with do
      new(
        transfer_id:    transfer_id,
        status:         status,
        value:          value.to_f,
        transfered_at:  DateTime.parse(transfered_at),
        transaction_id: transaction_id.to_i,
        created_at:     DateTime.parse(created_at),
        erro:           (!!erro),
        operacao:       operacao
      )
    end
  end
end
