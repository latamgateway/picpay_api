# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Remittance do
  let(:base_url) { ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze }
  let(:reference_id) { ENV['PICPAY_REFERENCE_ID'] }
  let(:url) { URI.join(base_url, '/v1/b2p/transfer') }
  let(:authorization) { build(:authorization) }

  let(:remittance) do
    described_class.new(
      base_url:      base_url,
      authorization: authorization,
      reference_id:  reference_id,
    )
  end

  let(:entity) { build(:remittance) }
  let(:payload) { entity.to_h }

  let(:remittance_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_400_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_400_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_401_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_401_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_403_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_403_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_404_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_404_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_409_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_409_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_422_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_422_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_429_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_429_response_body.json'),
      symbolize_names: true
    )
  end

  let(:remittance_error_500_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/remittance/error_500_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'manual transfer' do
    it 'performs manual transfer success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_success_response_body.to_json, status: 200)

      response = remittance.transfer(entity: entity)

      expect(response).to be_instance_of(PicPayApi::Entities::RemittanceResponse)
    end

    it 'performs manual transfer failure 400' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_400_response_body.to_json, status: 400)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 401' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_401_response_body.to_json, status: 401)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 403' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_403_response_body.to_json, status: 403)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPForbidden::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 404' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_404_response_body.to_json, status: 404)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPNotFound::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 409' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_409_response_body.to_json, status: 409)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPConflict::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 422' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_422_response_body.to_json, status: 422)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPUnprocessableEntity::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 429' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_429_response_body.to_json, status: 429)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPTooManyRequests::EXCEPTION_TYPE)
    end

    it 'performs manual transfer failure 500' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: remittance_error_500_response_body.to_json, status: 500)

      expect { remittance.transfer(entity: entity) }.to raise_error(Net::HTTPInternalServerError::EXCEPTION_TYPE)
    end
  end

end