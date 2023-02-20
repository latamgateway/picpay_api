# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Project do
  let(:base_url) { ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze }
  let(:url) { URI.join(base_url, '/b2p/v2/projects') }
  let(:authorization) { build(:authorization) }
  let(:project_id) { ENV['PICPAY_PROJECT_ID'] }

  let(:project) do
    described_class.new(
      base_url:      base_url,
      authorization: authorization,
      )
  end

  let(:entity) { build(:project) }
  let(:payload) { entity.to_h }

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

  describe 'manual create' do


    it 'performs manual create_success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_create_success_response_body.to_json, status: 200)

      response = project.create(entity: entity)

    end

    it "should include the :project_id attribute" do
      response = project.create(entity: entity)
      expect(response.attributes).to include(:project_id)
    end


    xit 'performs manual create_failure' do
      stub_request(:post, url)
        .with(body: payload.to_json)
      #.to_return()

      expect { response = project.create(entity: entity) }.to raise_error(PicPayApi::Errors::BadRequest)
                                                                .or raise_error(PicPayApi::Errors::Unauthorized)
                                                                .or raise_error(PicPayApi::Errors::ServerError)


    end

  end

  describe 'manual update' do
    it 'performs manual update_success' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_create_success_response_body.to_json, status: 200)

      response = project.update(project_id: project_id, entity: entity)

      puts response.inspect

      expect(response.project_id).to be_a(String)
      expect(response.name).to be_a(String)
      expect(response.payer_email).to be_a(String)
      expect(response.started_at).to be_a(Date)
      expect(response.ended_at).to be_a(DateTime)
      expect(response.ended_at).to be_a(T::Boolean)
      expect(response.payee_transaction_limit).to be_a(Integer)
      expect(response.payee_transaction_limit).to be_a(Integer)
      #
      # expect(response).to have_key(:name)
      # expect(response).to have_key(:payer_email)
      # expect(response).to have_key(:started_at)
      # expect(response).to have_key(:ended_at)
      # expect(response).to have_key(:withdrawable)
      # expect(response).to have_key(:payee_transaction_limit)
      # expect(response).to have_key(:payee_transaction_value)
      # expect(response).to have_key(:identical_transaction_rule)
      # expect(response).to have_key(:created_at)
      # expect(response).to have_key(:updated_at)
    end
  end

end