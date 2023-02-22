# typed: false
# frozen_string_literal: true

require 'time'

FactoryBot.define do
  factory :transfer, class: PicPayApi::Entities::Transfer do
    transfer_id { ENV['PICPAY_TRANSFER_ID'].to_s }
    status { ENV['PICPAY_TRANSFER_STATUS'].to_s }
    value { ENV['PICPAY_TRANSFER_VALUE'].to_f }
    transfered_at { DateTime.parse(ENV['PICPAY_TRANSFER_TRANSFERED_AT']) }
    transaction_id { ENV['PICPAY_TRANSFER_TRANSACTION_ID'].to_i }
    created_at { DateTime.parse(ENV['PICPAY_TRANSFER_CREATED_AT']) }
    error { (ENV['PICPAY_TRANSFER_ERROR'].to_s.downcase == 'true') }
    operation { ENV['PICPAY_TRANSFER_OPERATION'].to_s }

    initialize_with do
      new(
        transfer_id:    transfer_id,
        status:         status,
        value:          value,
        transfered_at:  transfered_at,
        transaction_id: transaction_id,
        created_at:     created_at,
        error:          error,
        operation:      operation
      )
    end
  end
end
