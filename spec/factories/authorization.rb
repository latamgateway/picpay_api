# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :authorization, class: PicPayApi::Entities::Authorization do
    type { ENV['PICPAY_TOKEN_TYPE'] }
    token { ENV['PICPAY_ACCESS_TOKEN'] }
    initialize_with do
      new(
        type: type,
        token: token
      )
    end
  end
end
