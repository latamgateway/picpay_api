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
    # @param [String] base_url Picpay API base URL.
    # @param [PicPayApi::Entities::Authorization] authorization Authorization Entity
    # @param [String] reference_id REFERENCE_ID sent by Picpay
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

    sig do
      params(
        entity: PicPayApi::Entities::Remittance,
      ).returns(PicPayApi::Entities::Remittance)
    end
    # This feature creates a transfer request, comparing the received values with the previously defined rules.
    # The transfer is completed only if the data is in accordance with the Project settings.
    #
    # @param [PicPayApi::Entities::Remittance] entity Remittance Entity with loaded data
    def transfer(entity:)
      response = PicPayApi::HTTP::Client.post(uri: @url, payload: entity.to_h, authorization: @authorization)

      body = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      error!(response: response, body: body)

      PicPayApi::Entities::Remittance.from_h(hash: body)
    end

    include PicPayApi::Errors::Error

  end
end
