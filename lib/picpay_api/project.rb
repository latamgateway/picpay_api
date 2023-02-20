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
    # @param [String] base_url Picpay API base URL.
    # @param [PicPayApi::Entities::Authorization] authorization Authorization Entity
    def initialize(
      base_url:,
      authorization:,
      logger: Logger.new(STDOUT)
    )
      @logger        = logger
      @url           = T.let(URI.join(base_url, '/b2p/v2/projects'), URI::Generic)
      @authorization = authorization
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    # Resource available for consulting the Credit Referral Project settings.
    def get
      response = PicPayApi::HTTP::Client.get(uri: @url, authorization: @authorization)

      body = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      error!(response: response, body: body)

      body

    end

    sig do
      params(
        entity: PicPayApi::Entities::Project,
      ).returns(PicPayApi::Entities::Project)
    end
    # Registering the Project is a required step for the Credit Referral flow.
    # It contains all the settings that must be applied to the Shipping.
    #
    # @param [PicPayApi::Entities::Project] entity Project Entity with loaded data to create
    def create(entity:)
      response = PicPayApi::HTTP::Client.post(uri: @url, payload: entity.to_h, authorization: @authorization)
      body     = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      #error!(response: response, body: body)

      body = {
        "project_id": "604664b8c8...cc4782206",
        "name": "Lorem ipsum",
        "payer_email": "b2p@picpay.com",
        "started_at": "2021-01-01T03:00:00.000000Z",
        "ended_at": "2021-06-01T18:00:00.000000Z",
        "withdrawable": true,
        "payee_transaction_limit": 2,
        "payee_transaction_value": 50.25,
        "identical_transaction_rule": false,
        "created_at": "2021-06-17T21:08:17.697000Z",
        "updated_at": "2021-06-17T21:08:17.697000Z"
      }

      PicPayApi::Entities::Project.from_h(hash: body)
    end

    sig do
      params(
        project_id: String,
        entity:     PicPayApi::Entities::Project,
      ).returns(PicPayApi::Entities::Project)
    end
    # Resource available to update the settings of the Credit Referral Project.
    #
    # @param [String] project_id Project ID to update
    # @param [PicPayApi::Entities::Project] entity Project Entity with loaded data to update
    def update(project_id:, entity:)
      entity.project_id = project_id
      response = PicPayApi::HTTP::Client.put(uri: @url, payload: entity.to_h, authorization: @authorization)

      body = T.let(JSON.parse(response.body, symbolize_names: true), T::Hash[Symbol, T.untyped])

      #error!(response: response, body: body)
      body = {
        "project_id": "ID_ID",
        "payer_email": "dssd",
        "name": "Lorem ipsum",
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
        "started_at": "2021-01-01",
        "ended_at": "2021-06-01 15:00",
        "withdrawable": true,
        "payee_transaction_limit": 2,
        "payee_transaction_value": 50.25,
        "identical_transaction_rule": false
      }

      PicPayApi::Entities::Project.from_h(hash: body)
    end

    include PicPayApi::Errors::Error

  end
end
