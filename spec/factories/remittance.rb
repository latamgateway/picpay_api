# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :remittance, class: PicPayApi::Entities::Remittance do
    reference_id { ENV['PICPAY_REFERENCE_ID'].to_s }
    consumer { ENV['PICPAY_REMITTANCE_CONSUMER'].to_s }
    value { ENV['PICPAY_REMITTANCE_VALUE'].to_f }

    initialize_with do
      new(
        consumer:     consumer,
        value:        value,
        reference_id: reference_id
      )
    end
  end
end
