# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

Dir.glob('picpay_api/**/*.rb', base: __dir__).each do |filepath|
  require_relative filepath
end

module PicPayApi
  extend T::Sig
  API_URL = T.let(ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze, String)
end
