# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

Dir.glob('picpay_api/**/*.rb', base: __dir__).each do |filepath|
  require_relative filepath
end

# This module will contain all functionalities used to wrap FitBank REST API
module PicPayApi
  extend T::Sig
  API_URL = T.let(ENV.fetch('API_URL', 'https://api.picpay.com').freeze, String)
end
