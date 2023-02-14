# typed: strict
# frozen_string_literal: true

require 'logger'

module PicPayApi
  class Project

    extend T::Sig

    sig { returns(Logger) }
    attr_accessor :logger

    sig { returns(URI::Generic) }
    attr_accessor :url

    sig { returns(PicPayApi::Entities::Authorization) }
    attr_accessor :authorization

    sig do
      params(
        base_url:      String,
        authorization: PicPayApi::Entities::Authorization,
        logger:        Logger
      ).void
    end
    def initialize(
      base_url:,
      authorization:,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      @url           = T.let(URI.join(base_url, '/b2p/v2/projects'), URI::Generic)
      @authorization = authorization
    end

    def create(entity:)
      response = PicPayApi::HTTP::Client.post!(uri: @url, payload: entity.to_h, authorization: @authorization)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      unless response.is_a?(Net::HTTPSuccess)
        raise PicPayApi::Errors::Authentication, body[:error_description]
      end

      body
    end

  end
end
