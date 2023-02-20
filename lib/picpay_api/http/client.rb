# typed: strict
# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module PicPayApi
  module HTTP
    class Client
      class << self

        extend T::Sig

        sig do
          params(
            uri:           URI::Generic,
            payload:       T.nilable(T::Hash[Symbol, T.untyped]),
            authorization: T.nilable(PicPayApi::Entities::Authorization),
          ).returns(T.untyped)
        end
        def get(uri:, payload: nil, authorization: nil)
          request = build(request: Net::HTTP::Get.new(uri), payload: payload, authorization: authorization)
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
        end

        sig do
          params(
            uri:           URI::Generic,
            payload:       T.nilable(T::Hash[Symbol, T.untyped]),
            authorization: T.nilable(PicPayApi::Entities::Authorization),
          ).returns(T.untyped)
        end
        def post(uri:, payload: nil, authorization: nil)
          request = build(request: Net::HTTP::Post.new(uri), payload: payload, authorization: authorization)
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
        end

        sig do
          params(
            uri:           URI::Generic,
            payload:       T::Hash[Symbol, T.untyped],
            authorization: T.nilable(PicPayApi::Entities::Authorization),
          ).returns(T.untyped)
        end
        def put(uri:, payload:, authorization: nil)
          request = build(request: Net::HTTP::Put.new(uri), payload: payload, authorization: authorization)
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
        end

        private

        sig do
          params(
            request:       Net::HTTPGenericRequest,
            payload:       T.nilable(T::Hash[Symbol, T.untyped]),
            authorization: T.nilable(PicPayApi::Entities::Authorization),
          ).returns(Net::HTTPGenericRequest)
        end
        def build(request:, payload: nil, authorization: nil)
          request.body             = payload.to_json unless payload.nil?
          request['accept']        = 'application/json'
          request['content-type']  = 'application/json'
          request['authorization'] = authorization.to_s unless authorization.nil?

          request
        end

      end
    end
  end
end
