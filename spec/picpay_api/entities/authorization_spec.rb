# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::Authorization do
  describe 'Object' do

    let!(:type) { 'bearer' }
    let!(:token) { 'eyJhbGciOiJIUzI1NVCJ9.eyJkYXRhIjoidmFsdWUifQ.78pp6_Dx5L0fz-xkpUEbZI' }

    context 'attributes' do
      it 'has attr_accessors' do
        authorization = described_class.new(
          type:  type,
          token: token,
        )

        expect(authorization).to respond_to(:type)
        expect(authorization).to respond_to(:token)

        expect(authorization).to respond_to(:type=)
        expect(authorization).to respond_to(:token=)

      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        authorization = described_class.new(
          type:  type,
          token: token,
        )

        expect(authorization.type).to eq(type)
        expect(authorization.token).to eq(token)
      end
    end
  end
end
