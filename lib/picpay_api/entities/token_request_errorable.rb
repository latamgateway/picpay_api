# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    module TokenRequestErrorable

      class Error < Struct.new(:error, :error_description)
        ERRORS = %w[
          invalid_request
          invalid_client
          invalid_grant
          unauthorized_client
          unsupported_grant_type
        ].freeze

        def self.from_hash(hash)
          new(
            error:             hash.fetch(:error),
            error_description: hash.fetch(:error_description),
            )
        end
      end

      class Success < Struct.new(:access_token, :expires_in, :refresh_expires_in, :refresh_token, :token_type)
        def self.from_hash(hash)
          new(
            access_token:       hash.fetch(:access_token),
            expires_in:         hash.fetch(:expires_in),
            refresh_expires_in: hash.fetch(:refresh_expires_in),
            refresh_token:      hash.fetch(:refresh_token),
            token_type:         hash.fetch(:token_type),
            )
        end
      end

    end
  end
end