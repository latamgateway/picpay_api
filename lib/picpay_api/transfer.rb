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
      @url           = T.let(URI.join(base_url, '/b2p/v2/transfer/reference_id/' + reference_id), URI::Generic)
      @authorization = authorization
      @reference_id  = reference_id
    end

    sig { returns(PicPayApi::Entities::Transfer) }
    # Resource made available by consulting a Reference ID Transfer
    def get
      body = PicPayApi::HTTP::Client.get(uri: @url, authorization: @authorization)
      PicPayApi::Entities::Transfer.from_h(hash: body)
    end
  end
end
