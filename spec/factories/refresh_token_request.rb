# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token_request, class: PicPayApi::Entities::RefreshTokenRequest do
    client_id { ENV['CLIENT_ID'] }
    client_secret { ENV['CLIENT_SECRET'] }
    refresh_token { ENV['REFRESH_TOKEN'] }
    initialize_with do
      new(
        client_id: client_id,
        client_secret: client_secret,
        refresh_token: refresh_token
      )
    end
  end
end
