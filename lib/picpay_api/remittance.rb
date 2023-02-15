# typed: strict
# frozen_string_literal: true

require 'logger'

module PicPayApi
  class Remittance

    extend T::Sig

    sig { returns(Logger) }
    attr_accessor :logger

    sig { returns(URI::Generic) }
    attr_accessor :url

    sig { returns(PicPayApi::Entities::Authorization) }
    attr_accessor :authorization

    sig { returns(String) }
    attr_accessor :reference_id

    sig do
      params(
        base_url:      String,
        authorization: PicPayApi::Entities::Authorization,
        reference_id:  String,
        logger:        Logger
      ).void
    end
    def initialize(
      base_url:,
      authorization:,
      reference_id:,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      @url           = T.let(URI.join(base_url, '/v1/b2p/transfer'), URI::Generic)
      @authorization = authorization
      @reference_id  = reference_id
    end


    def transfer(entity:)
      if entity.project_id.nil?
        response = PicPayApi::HTTP::Client.post!(uri: @url, payload: entity.to_h, authorization: @authorization)
      else
        response = PicPayApi::HTTP::Client.put!(uri: @url, payload: entity.to_h, authorization: @authorization)
      end

      body = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      if response.is_a?(Net::HTTPServerError)
        raise PicPayApi::Errors::ServerError, body[:message]
      elsif response.is_a?(Net::HTTPUnprocessableEntity)
        raise PicPayApi::Errors::BadRequest, body[:message]
      elsif response.is_a?(Net::HTTPBadRequest) || response.is_a?(Net::HTTPUnauthorized)
        raise PicPayApi::Errors::Unauthorized, body[:message]
      end

      body
    end

  end
end
