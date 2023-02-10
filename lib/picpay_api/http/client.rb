# typed: strict
# frozen_string_literal: true

require 'logger'
require 'net/http'
require 'uri'
require 'json'

module PicPayApi
  module HTTP
    class Client

      extend T::Sig

      sig do
        params(
          uri:     URI::Generic,
          payload: T::Hash[Symbol, T.untyped],
        ).returns(T.untyped)
      end
      def self.post!(uri, payload)
        request                 = Net::HTTP::Post.new(uri)
        request.body            = payload.to_json
        request['accept']       = 'application/json'
        request['content-type'] = 'application/json'

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

      end

    end
  end
end
