# typed: false
# frozen_string_literal: true

require 'spec_helper'
extend T::Sig

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

  let(:project_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:project_error_400_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/error_400_response_body.json'),
      symbolize_names: true
    )
  end

  let(:project_error_401_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/error_401_response_body.json'),
      symbolize_names: true
    )
  end

  let(:project_error_422_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/error_422_response_body.json'),
      symbolize_names: true
    )
  end

  let(:project_error_503_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/error_503_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'manual create' do
    it 'performs manual create_success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_success_response_body.to_json, status: 200)

      response = project.create(entity: entity)

      expect(response).to be_instance_of(PicPayApi::Entities::Project)
    end

    it 'performs manual create_failure_400' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_400_response_body.to_json, status: 400)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

    it 'performs manual create_failure_401' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_401_response_body.to_json, status: 401)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual create_failure_422' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_422_response_body.to_json, status: 422)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPUnprocessableEntity::EXCEPTION_TYPE)
    end

    it 'performs manual create_failure_503' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_503_response_body.to_json, status: 503)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPServiceUnavailable::EXCEPTION_TYPE)
    end
  end

  describe 'manual update' do
    it 'performs manual update_success' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_success_response_body.to_json, status: 200)

      response = project.update(project_id: project_id, entity: entity)

      expect(response).to be_instance_of(PicPayApi::Entities::Project)
    end
  end

end