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

    sig { returns(PicPayApi::Entities::ProjectsResponse) }
    # Resource available for consulting the Credit Referral Project settings.
    def get
      body = PicPayApi::HTTP::Client.get(uri: @url, authorization: @authorization)
      PicPayApi::Entities::ProjectsResponse.from_h(body)
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
      body = PicPayApi::HTTP::Client.post(uri: @url, payload: entity.to_h, authorization: @authorization)
      PicPayApi::Entities::Project.from_h(body)
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
      body = PicPayApi::HTTP::Client.put(uri: @url, payload: entity.to_h, authorization: @authorization)
      PicPayApi::Entities::Project.from_h(body)
    end

  end
end
