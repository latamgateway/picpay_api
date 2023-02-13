#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "picpay_api"
require 'dotenv'

p = PicPayApi::Authentication.new(
  base_url:      PicPayApi::API_URL,
  client_id:     ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET'],
)

exit