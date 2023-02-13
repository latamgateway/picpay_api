# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::TokenRequest do
  describe 'Object' do
    let!(:client_id) { '7461f6d2-1ac9-4daa-851f-57259c49d859' }
    let!(:client_secret) { '7461f6d2-1ac9-4daa-851f-57259c49d859' }

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
