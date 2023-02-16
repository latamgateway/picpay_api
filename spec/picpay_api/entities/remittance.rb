# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::Remittance do
  describe 'Object' do

    let!(:reference_id) { '3914d09f-c702-45e9-a9c7-1ae92dbda0d5' }
    let!(:consumer) { '00011122200' }
    let!(:value) { 99.99 }

    context 'attributes' do
      it 'has attr_accessors' do
        remittance = described_class.new(
          consumer:     consumer.to_s,
          value:        value.to_f,
          reference_id: reference_id,
        )

        expect(remittance).to respond_to(:consumer)
        expect(remittance).to respond_to(:value)
        expect(remittance).to respond_to(:reference_id)

        expect(remittance).to respond_to(:consumer=)
        expect(remittance).to respond_to(:value=)
        expect(remittance).to respond_to(:reference_id=)

      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        remittance = described_class.new(
          consumer:     consumer.to_s,
          value:        value.to_f,
          reference_id: reference_id,
        )

        expect(remittance.consumer).to eq(consumer.to_s)
        expect(remittance.value).to eq(value.to_f)
        expect(remittance.reference_id).to eq(reference_id)
      end
    end
  end
end
