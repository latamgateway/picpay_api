# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token_request, class: PicPayApi::Entities::RefreshTokenRequest do
    client_id { ENV['PICPAY_CLIENT_ID'].to_s }
    client_secret { ENV['PICPAY_CLIENT_SECRET'].to_s }
    refresh_token { ENV['PICPAY_REFRESH_TOKEN'].to_s }
    initialize_with do
      new(
        client_id: client_id,
        client_secret: client_secret,
        refresh_token: refresh_token
      )
    end
  end
end
