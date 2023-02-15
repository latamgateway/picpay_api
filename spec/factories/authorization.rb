# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :authorization, class: PicPayApi::Entities::Authorization do
    type { ENV['TOKEN_TYPE'] }
    token { ENV['ACCESS_TOKEN'] }
    initialize_with do
      new(
        type: type,
        token: token
      )
    end
  end
end
