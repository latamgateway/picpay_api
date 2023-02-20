# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::Remittance do
  describe 'Object' do

    let!(:reference_id) { ENV['PICPAY_REFERENCE_ID'] }
    let!(:consumer) { ENV['PICPAY_REMITTANCE_CONSUMER'].to_s }
    let!(:value) { ENV['PICPAY_REMITTANCE_VALUE'].to_f }

    context 'attributes' do
      it 'has attr_accessors' do
        remittance = described_class.new(
          consumer:     consumer,
          value:        value,
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
          consumer:     consumer,
          value:        value,
          reference_id: reference_id,
        )

        expect(remittance.consumer).to eq(consumer)
        expect(remittance.value).to eq(value)
        expect(remittance.reference_id).to eq(reference_id)
      end
    end
  end
end
