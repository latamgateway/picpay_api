# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :projects_response, class: PicPayApi::Entities::ProjectsResponse do
    total { ENV['PICPAY_PROJECTS_RESPONSE_TOTAL'].to_i }
    current_page { ENV['PICPAY_PROJECTS_RESPONSE_CURRENT_PAGE'].to_i }
    last_page { ENV['PICPAY_PROJECTS_RESPONSE_LAST_PAGE'].to_i }
    per_page { ENV['PICPAY_PROJECTS_RESPONSE_PER_PAGE'].to_i }
    data { [build(:project)] }

    initialize_with do
      new(
        total: total,
        current_page: current_page,
        last_page: last_page,
        per_page: per_page,
        data: data,
      )
    end
  end
end
