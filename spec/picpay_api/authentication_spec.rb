# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Authentication do
  let(:base_url) { ENV.fetch('PICPAY_API_URL', 'https://api.picpay.com').freeze }
  let!(:client_id) { ENV['PICPAY_CLIENT_ID'].to_s }
  let!(:client_secret) { ENV['PICPAY_CLIENT_SECRET'].to_s }
  let(:url) { URI.join(base_url, '/oauth2/token') }

  let(:authentication) do
    described_class.new(base_url: base_url, client_id: client_id, client_secret: client_secret)
  end

  let(:token_request_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/authentication/token_request_success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:token_request_failure_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/authentication/token_request_failure_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'manual token_request' do
    let(:payload) { build(:token_request).to_h }

    it 'performs manual token_request success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: token_request_success_response_body.to_json, status: 200)

      response = authentication.token_request.to_h

      expect(response).to have_key(:access_token)
      expect(response).to have_key(:expires_in)
      expect(response).to have_key(:refresh_expires_in)
      expect(response).to have_key(:refresh_token)
      expect(response).to have_key(:token_type)
    end

    it 'performs manual token_request failure' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: token_request_failure_response_body.to_json, status: 400)

      expect { authentication.token_request }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end

  end

  describe 'manual refresh_token_request' do
    let(:refresh_token) do
      token_request_success_response_body[:refresh_token]
    end
    let(:payload) { build(:refresh_token_request).to_h }

    it 'performs manual refresh_token_request success' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: token_request_success_response_body.to_json, status: 200)

      response = authentication.refresh_token_request(refresh_token: refresh_token).to_h

      expect(response).to have_key(:access_token)
      expect(response).to have_key(:expires_in)
      expect(response).to have_key(:refresh_expires_in)
      expect(response).to have_key(:refresh_token)
      expect(response).to have_key(:token_type)
    end

    it 'performs manual refresh_token_request failure' do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: token_request_failure_response_body.to_json, status: 400)

      expect { authentication.refresh_token_request(refresh_token: refresh_token) }.to raise_error(Net::HTTPBadRequest::EXCEPTION_TYPE)
    end
  end

end