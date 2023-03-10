# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::TokenRequest do
  describe 'Object' do
    let!(:client_id) { ENV['PICPAY_CLIENT_ID'].to_s }
    let!(:client_secret) { ENV['PICPAY_CLIENT_SECRET'].to_s }

    context 'attributes' do
      it 'has attr_accessors' do
        token_request = described_class.new(
          client_id:     client_id,
          client_secret: client_secret
        )

        expect(token_request).to respond_to(:client_id)
        expect(token_request).to respond_to(:client_secret)

        expect(token_request).to respond_to(:client_id=)
        expect(token_request).to respond_to(:client_secret=)
      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        token_request = described_class.new(
          client_id:     client_id,
          client_secret: client_secret
        )

        expect(token_request.client_id).to eq(client_id)
        expect(token_request.client_secret).to eq(client_secret)
      end
    end
  end
end
