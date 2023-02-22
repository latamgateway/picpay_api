# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :authorization, class: PicPayApi::Entities::Authorization do
    type { ENV['PICPAY_TOKEN_TYPE'].to_s }
    token { ENV['PICPAY_ACCESS_TOKEN'].to_s }
    initialize_with do
      new(
        type: type,
        token: token
      )
    end
  end
end
