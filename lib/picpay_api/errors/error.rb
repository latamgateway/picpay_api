# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Errors
    module Error

      private

      def error!(response:, body:)
        if response.is_a?(Net::HTTPServerError)
          raise PicPayApi::Errors::ServerError, body[:message]
        elsif response.is_a?(Net::HTTPUnprocessableEntity)
          raise PicPayApi::Errors::BadRequest, body[:message]
        elsif response.is_a?(Net::HTTPBadRequest) || response.is_a?(Net::HTTPUnauthorized)
          raise PicPayApi::Errors::Unauthorized, body[:message]
        end
      end
    end
  end
end