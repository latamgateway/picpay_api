# typed: false
# frozen_string_literal: true

RSpec.describe PicPayApi::Entities::ProjectsResponse do
  describe 'Object' do

    let!(:total) { ENV['PICPAY_PROJECTS_RESPONSE_TOTAL'].to_i }
    let!(:current_page) { ENV['PICPAY_PROJECTS_RESPONSE_CURRENT_PAGE'].to_i }
    let!(:last_page) { ENV['PICPAY_PROJECTS_RESPONSE_LAST_PAGE'].to_i }
    let!(:per_page) { ENV['PICPAY_PROJECTS_RESPONSE_PER_PAGE'].to_i }
    let!(:entity) { build(:project) }
    let!(:data) do
      list = []
      list.push(entity)
    end

    context 'attributes' do
      it 'has attr_accessors' do
        projects_response = described_class.new(
          total:        total,
          current_page: current_page,
          last_page:    last_page,
          per_page:     per_page,
          data:         data,
        )

        expect(projects_response).to respond_to(:total)
        expect(projects_response).to respond_to(:current_page)
        expect(projects_response).to respond_to(:last_page)
        expect(projects_response).to respond_to(:per_page)
        expect(projects_response).to respond_to(:data)

        expect(projects_response).to respond_to(:total=)
        expect(projects_response).to respond_to(:current_page=)
        expect(projects_response).to respond_to(:last_page=)
        expect(projects_response).to respond_to(:per_page=)
        expect(projects_response).to respond_to(:data=)
      end
    end

    context 'initialization' do
      it 'is initialized with correct values' do
        projects_response = described_class.new(
          total:        total,
          current_page: current_page,
          last_page:    last_page,
          per_page:     per_page,
          data:         data,
        )

        expect(projects_response.total).to eq(total)
        expect(projects_response.current_page).to eq(current_page)
        expect(projects_response.last_page).to eq(last_page)
        expect(projects_response.per_page).to eq(per_page)
        expect(projects_response.data).to eq(data)
      end
    end
  end
end
