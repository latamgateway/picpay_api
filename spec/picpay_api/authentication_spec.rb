# typed: false
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PicPayApi::Authentication do
  let(:base_url) { ENV.fetch('API_URL', 'https://api.picpay.com').freeze }
  let(:client_id) { '7461f6d2-1ac9-4daa-851f-57259c49d859' }
  let(:client_secret) { '7461f6d2-1ac9-4daa-851f-57259c49d859' }

  let(:authentication) do
    described_class.new(
      base_url:      base_url,
      client_id:     '7461f6d2-1ac9-4daa-851f-57259c49d859',
      client_secret: '7461f6d2-1ac9-4daa-851f-57259c49d859',
      )
  end

  let(:token_request_success_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/token_request_success_response_body.json'),
      symbolize_names: true
    )
  end

  let(:token_request_failure_response_body) do
    JSON.parse(
      File.read('./spec/fixtures/token_request_failure_response_body.json'),
      symbolize_names: true
    )
  end

  describe 'test' do
    let(:auth_url) { URI.join(base_url, '/oauth2/token') }

    let(:payload) { build(:token_request) }

    it 'does somethign' do
      puts "here"
    end

  end

  describe 'manual token_request' do
    let(:auth_url) { URI.join(base_url, '/oauth2/token') }

    let(:payload) { build(:token_request).to_h }

    it 'performs manual token_request_success' do
      stub_request(:post, auth_url)
        .with(body: payload.to_json)
        .to_return(body: token_request_success_response_body.to_json, status: 200)

      response = authentication.token_request

      expect(response).to have_key(:access_token)
      expect(response).to have_key(:expires_in)
      expect(response).to have_key(:refresh_expires_in)
      expect(response).to have_key(:refresh_token)
      expect(response).to have_key(:token_type)
    end

    it 'performs manual token_request_failure' do
      stub_request(:post, auth_url)
        .with(body: payload.to_json)
        .to_return(body: token_request_failure_response_body.to_json, status: 400)

      expect { authentication.token_request }.to raise_error(PicPayApi::Errors::Unauthorized)
    end

  end

  describe 'manual refresh_token_request' do
    let(:refresh_token) do
      token_request_success_response_body[:refresh_token]
    end

    let(:auth_url) { URI.join(base_url, '/oauth2/token') }


    let(:payload) { build(:refresh_token_request).to_h }

    it 'performs manual refresh_token_request_success' do
      stub_request(:post, auth_url)
        .with(body: payload.to_json)
        .to_return(body: token_request_success_response_body.to_json, status: 200)

      response = authentication.refresh_token_request(refresh_token: refresh_token)

      expect(response).to have_key(:access_token)
      expect(response).to have_key(:expires_in)
      expect(response).to have_key(:refresh_expires_in)
      expect(response).to have_key(:refresh_token)
      expect(response).to have_key(:token_type)
    end

    it 'performs manual refresh_token_request_failure' do
      stub_request(:post, auth_url)
        .with(body: payload.to_json)
        .to_return(body: token_request_failure_response_body.to_json, status: 400)

      expect { authentication.refresh_token_request(refresh_token: refresh_token) }.to raise_error(PicPayApi::Errors::Unauthorized)
    end
  end

end