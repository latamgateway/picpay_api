# typed: false
# frozen_string_literal: true

require 'time'

FactoryBot.define do
  factory :project, class: PicPayApi::Entities::Project do
    name { ENV['PROJECT_NAME'] }
    description { ENV['PROJECT_DESCRIPTION'] }
    started_at { ENV['PROJECT_STARTED_AT'] }
    ended_at { ENV['PROJECT_ENDED_AT'] }
    withdrawable { ENV['PROJECT_WITHDRAWABLE'] }
    payee_transaction_limit { ENV['PROJECT_PAYEE_TRANSACTION_LIMIT'] }
    payee_transaction_value { ENV['PROJECT_PAYEE_TRANSACTION_VALUE'] }
    identical_transaction_rule { ENV['PROJECT_IDENTICAL_TRANSACTION_RULE'] }

    initialize_with do
      new(
        name: name,
        description: description,
        started_at: Date.parse(started_at),
        ended_at: DateTime.parse(started_at),
        withdrawable: (!!withdrawable),
        payee_transaction_limit: payee_transaction_limit.to_i,
        payee_transaction_value: payee_transaction_value.to_f,
        identical_transaction_rule: (!!identical_transaction_rule),
      )
    end
  end
end
