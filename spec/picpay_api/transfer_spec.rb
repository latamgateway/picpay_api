# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Transfer do
  let(:base_url) { ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze }
  let(:reference_id) { ENV['PICPAY_REFERENCE_ID'] }
  let(:url) { URI.join(base_url, '/b2p/v2/transfer/reference_id/' + +reference_id) }
  let(:authorization) { build(:authorization) }

  let(:transfer) do
    described_class.new(
      base_url:      base_url,
      authorization: authorization,
      reference_id:  reference_id,
    )
  end

  let(:entity) { build(:transfer) }
  let(:payload) { entity.to_h }

  let(:transfer_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/transfer/success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:transfer_error_400_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/transfer/error_400_response_body.json'),
      symbolize_names: true
    )
  end

  let(:transfer_error_401_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/transfer/error_401_response_body.json'),
      symbolize_names: true
    )
  end

  let(:transfer_error_404_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/transfer/error_404_response_body.json'),
      symbolize_names: true
    )
  end

  let(:transfer_error_503_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/transfer/error_503_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'manual get' do
    it 'performs manual get success' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: transfer_success_response_body.to_json, status: 200)

      response = transfer.get

      expect(response).to be_instance_of(PicPayApi::Entities::Transfer)
    end

    it 'performs manual get failure 400' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: transfer_error_400_response_body.to_json, status: 400)

      expect { transfer.get }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 401' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: transfer_error_401_response_body.to_json, status: 401)

      expect { transfer.get }.to raise_error(Net::HTTPUnauthorized::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 404' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: transfer_error_401_response_body.to_json, status: 404)

      expect { transfer.get }.to raise_error(Net::HTTPNotFound::EXCEPTION_TYPE)
    end

    it 'performs manual get failure 503' do
      stub_request(:get, url)
        .with(body: '')
        .to_return(body: transfer_error_503_response_body.to_json, status: 503)

      expect { transfer.get }.to raise_error(Net::HTTPServiceUnavailable::EXCEPTION_TYPE)
    end
  end

end