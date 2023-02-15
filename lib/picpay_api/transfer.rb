# typed: strict
# frozen_string_literal: true

require 'logger'

module PicPayApi
  class Transfer

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
      @url           = T.let(URI.join(base_url, '/b2p/v2/transfer/reference_id/' + reference_id), URI::Generic)
      @authorization = authorization
      @reference_id  = reference_id
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def get
      response = PicPayApi::HTTP::Client.get!(uri: @url, authorization: @authorization)

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
