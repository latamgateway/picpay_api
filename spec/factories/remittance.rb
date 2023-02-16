# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :remittance, class: PicPayApi::Entities::Remittance do
    reference_id { ENV['REFERENCE_ID'] }
    consumer { ENV['REMITTANCE_CONSUMER'] }
    value { ENV['REMITTANCE_VALUE'] }

    initialize_with do
      new(
        consumer:     consumer.to_s,
        value:        value,
        reference_id: reference_id
      )
    end
  end
end
