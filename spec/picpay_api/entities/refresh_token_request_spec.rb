# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::RefreshTokenRequest do
  describe 'Object' do
    let!(:client_id) { ENV['PICPAY_CLIENT_ID'].to_s }
    let!(:client_secret) { ENV['PICPAY_CLIENT_SECRET'].to_s }
    let!(:refresh_token) { ENV['PICPAY_REFRESH_TOKEN'].to_s }

    context 'attributes' do
      it 'has attr_accessors' do
        refresh_token_request = described_class.new(
          client_id:     client_id,
          client_secret: client_secret,
          refresh_token: refresh_token
        )

        expect(refresh_token_request).to respond_to(:client_id)
        expect(refresh_token_request).to respond_to(:client_secret)
        expect(refresh_token_request).to respond_to(:refresh_token)

        expect(refresh_token_request).to respond_to(:client_id=)
        expect(refresh_token_request).to respond_to(:client_secret=)
        expect(refresh_token_request).to respond_to(:refresh_token=)
      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        refresh_token_request = described_class.new(
          client_id:     client_id,
          client_secret: client_secret,
          refresh_token: refresh_token
        )

        expect(refresh_token_request.client_id).to eq(client_id)
        expect(refresh_token_request.client_secret).to eq(client_secret)
        expect(refresh_token_request.refresh_token).to eq(refresh_token)

      end
    end
  end
end
