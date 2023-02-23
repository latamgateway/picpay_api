# typed: strict
# frozen_string_literal: true

module PicPayApi
  module Entities
    class ProjectsResponse < T::Struct

      extend T::Sig

      # @!attribute total
      #   @return [Integer]
      prop :total, Integer

      # @!attribute current_page
      #   @return [Integer]
      prop :current_page, Integer

      # @!attribute last_page
      #   @return [Integer]
      prop :last_page, Integer

      # @!attribute per_page
      #   @return [Integer]
      prop :per_page, Integer

      # @!attribute data
      #   @return [Array]
      prop :data, Array

      sig { returns(T::Hash[T.untyped, T.untyped]) }
      def to_h
        {
          total:        @total,
          current_page: @current_page,
          last_page:    @last_page,
          per_page:     @per_page,
          data:         @data,
        }
      end

      sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PicPayApi::Entities::ProjectsResponse) }
      def self.from_h(hash)
        PicPayApi::Entities::ProjectsResponse.new(
          total:        hash[:total].to_i,
          current_page: hash[:current_page].to_i,
          last_page:    hash[:last_page].to_i,
          per_page:     hash[:per_page].to_i,
          data:         hash[:data].map!{ |project| PicPayApi::Entities::Project.from_hash(project) },
        )
      end

    end
  end
end
