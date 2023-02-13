# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :token_request, class: PicPayApi::Entities::TokenRequest do
    client_id { ENV['CLIENT_ID'] }
    client_secret { ENV['CLIENT_SECRET'] }
    initialize_with do
      new(
        client_id: client_id,
        client_secret: client_secret
      )
    end
  end
end
