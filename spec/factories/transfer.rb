# typed: false
# frozen_string_literal: true

require 'time'

FactoryBot.define do
  factory :transfer, class: PicPayApi::Entities::Transfer do
    transfer_id { ENV['PICPAY_TRANSFER_ID'].to_s }
    status { ENV['PICPAY_TRANSFER_STATUS'] }
    value { ENV['PICPAY_TRANSFER_VALUE'].to_f }
    transfered_at { DateTime.parse(ENV['PICPAY_TRANSFER_TRANSFERED_AT']) }
    transaction_id { ENV['PICPAY_TRANSFER_TRANSACTION_ID'].to_i }
    created_at { DateTime.parse(ENV['PICPAY_TRANSFER_CREATED_AT']) }
    erro { !!ENV['PICPAY_TRANSFER_ERRO'] }
    operacao { ENV['PICPAY_TRANSFER_OPERACAO'] }

    initialize_with do
      new(
        transfer_id:    transfer_id,
        status:         status,
        value:          value,
        transfered_at:  transfered_at,
        transaction_id: transaction_id,
        created_at:     created_at,
        erro:           erro,
        operacao:       operacao
      )
    end
  end
end
