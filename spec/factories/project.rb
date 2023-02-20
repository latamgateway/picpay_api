# typed: false
# frozen_string_literal: true

require 'time'

FactoryBot.define do
  factory :project, class: PicPayApi::Entities::Project do
    name { ENV['PICPAY_PROJECT_NAME'] }
    description { ENV['PICPAY_PROJECT_DESCRIPTION'] }
    started_at { Date.parse(ENV['PICPAY_PROJECT_STARTED_AT']) }
    ended_at { DateTime.parse(ENV['PICPAY_PROJECT_ENDED_AT']) }
    withdrawable { !!ENV['PICPAY_PROJECT_WITHDRAWABLE'] }
    payee_transaction_limit { ENV['PICPAY_PROJECT_PAYEE_TRANSACTION_LIMIT'].to_i }
    payee_transaction_value { ENV['PICPAY_PROJECT_PAYEE_TRANSACTION_VALUE'].to_f }
    identical_transaction_rule { !!ENV['PICPAY_PROJECT_IDENTICAL_TRANSACTION_RULE'] }

    initialize_with do
      new(
        name: name,
        description: description,
        started_at: started_at,
        ended_at: ended_at,
        withdrawable: withdrawable,
        payee_transaction_limit: payee_transaction_limit,
        payee_transaction_value: payee_transaction_value,
        identical_transaction_rule: identical_transaction_rule,
      )
    end
  end
end
