#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "picpay_api"
require 'dotenv'

Dotenv.load('./.env.development')

p = PicPayApi::Authentication.new(
  base_url:      PicPayApi::API_URL,
  client_id:     ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET'],
)

a = PicPayApi::Entities::Authorization.new(
  type:  ENV['TOKEN_TYPE'],
  token: ENV['ACCESS_TOKEN']
)

url = T.let(URI.join(PicPayApi::API_URL, '/b2p/v2/projects'), URI::Generic)
payload = {
  "access_token": "eyJhbGciOiJIUzI1NVCJ9.eyJkYXRhIjoidmFsdWUifQ.78pp6_Dx5L0fz-xkpUEbZI",
  "expires_in": 300,
  "refresh_expires_in": 1800,
  "refresh_token": "yJkYXRhIjoidmFsdWUifQ.78pp6_Dx5L0fz-xkpUEbZI.yJhbGciOiJIUzI1NVCJ9",
  "token_type": "bearer"
}

b = PicPayApi::HTTP::Client::post!(
  url,
  payload,
  authorization: a
)

puts a.inspect


j = p.token_request

puts a.inspect
#puts j.inspect

exit