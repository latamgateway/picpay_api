# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Project do
  let(:base_url) { ENV.fetch('API_URL', 'https://api.picpay.com').freeze }

  let(:authorization) { build(:authorization) }

  let(:project) do
    described_class.new(
      base_url:      base_url,
      authorization: authorization,
      )
  end

  let(:project_create_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project_create_success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:token_request_failure_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/token_request_failure_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'manual create_or_update' do
    let(:url) { URI.join(base_url, '/b2p/v2/projects') }

    let(:entity) { build(:project) }
    let(:payload) { entity.to_h }

    it 'performs manual create_or_update_success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_create_success_response_body.to_json, status: 200)

      response = project.create_or_update(entity: entity)

      expect(response).to have_key(:project_id)
      expect(response).to have_key(:name)
      expect(response).to have_key(:payer_email)
      expect(response).to have_key(:started_at)
      expect(response).to have_key(:ended_at)
      expect(response).to have_key(:withdrawable)
      expect(response).to have_key(:payee_transaction_limit)
      expect(response).to have_key(:payee_transaction_value)
      expect(response).to have_key(:identical_transaction_rule)
      expect(response).to have_key(:created_at)
      expect(response).to have_key(:updated_at)
    end
  end

end