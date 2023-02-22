# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Project do
  let(:base_url) { ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze }
  let(:url) { URI.join(base_url, '/b2p/v2/projects') }
  let(:authorization) { build(:authorization) }
  let(:project_id) { ENV['PICPAY_PROJECT_ID'].to_s }

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

  let(:project_data_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/data_response_body.json'),
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

  let(:project_error_404_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/project/error_404_response_body.json'),
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

  describe 'manual get' do
    it 'performs manual get success' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: project_data_response_body.to_json, status: 200)

      response = project.get

      expect(response).to have_key(:data)
      expect(response).to have_key(:total)
      expect(response).to have_key(:current_page)
      expect(response).to have_key(:last_page)
      expect(response).to have_key(:per_page)
    end

    it 'performs manual get failure 400' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: project_error_400_response_body.to_json, status: 400)

      expect { project.get }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 401' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: project_error_401_response_body.to_json, status: 401)

      expect { project.get }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 422' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: project_error_422_response_body.to_json, status: 422)

      expect { project.get }.to raise_error(Net::HTTPUnprocessableEntity::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 503' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: project_error_503_response_body.to_json, status: 503)

      expect { project.get }.to raise_error(Net::HTTPServiceUnavailable::EXCEPTION_TYPE)
    end
  end


  describe 'manual create' do
    it 'performs manual create success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_success_response_body.to_json, status: 200)

      response = project.create(entity: entity)

      expect(response).to be_instance_of(PicPayApi::Entities::Project)
    end

    it 'performs manual create failure 400' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_400_response_body.to_json, status: 400)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

    it 'performs manual create failure 401' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_401_response_body.to_json, status: 401)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual create failure 422' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_422_response_body.to_json, status: 422)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPUnprocessableEntity::EXCEPTION_TYPE)
    end

    it 'performs manual create failure 503' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: project_error_503_response_body.to_json, status: 503)

      expect { project.create(entity: entity) }.to raise_error(Net::HTTPServiceUnavailable::EXCEPTION_TYPE)
    end
  end

  describe 'manual update' do
    it 'performs manual update success' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_success_response_body.to_json, status: 200)

      response = project.update(project_id: project_id, entity: entity)

      expect(response).to be_instance_of(PicPayApi::Entities::Project)
    end

    it 'performs manual update failure 401' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_error_401_response_body.to_json, status: 401)

      expect { project.update(project_id: project_id, entity: entity) }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual update failure 404' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_error_404_response_body.to_json, status: 404)

      expect { project.update(project_id: project_id, entity: entity) }.to raise_error(Net::HTTPNotFound::EXCEPTION_TYPE)
    end

    it 'performs manual update failure 422' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_error_422_response_body.to_json, status: 422)

      expect { project.update(project_id: project_id, entity: entity) }.to raise_error(Net::HTTPUnprocessableEntity::EXCEPTION_TYPE)
    end

    it 'performs manual update failure 503' do
      stub_request(:put, url)
        .with(body: { project_id: project_id }.merge!(payload).to_json)
        .to_return(body: project_error_503_response_body.to_json, status: 503)

      expect { project.update(project_id: project_id, entity: entity) }.to raise_error(Net::HTTPServiceUnavailable::EXCEPTION_TYPE)
    end
  end

end