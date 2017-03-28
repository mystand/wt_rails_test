require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET index' do
    let!(:companies) { create_list :company, 5 }

    it 'return status 200' do
      get :index
      expect(response).to have_http_status :ok
    end

    it 'return document types' do
      get :index
      expect(json['collection'].size).to eq 5
    end
  end

  describe 'POST create' do
    let!(:attributes) { { name: Faker::Company.name } }

    it 'return status 200' do
      post :create, attributes
      expect(response).to have_http_status :ok
    end

    it 'return document' do
      post :create, attributes
      expect(json).to include('id', 'name')
    end
  end

  describe 'POST generate' do
    it 'return status 204' do
      post :generate, params: { count: 100 }
      expect(response).to have_http_status :no_content
    end

    it 'creates companies' do
      post :generate, params: { count: 100 }
      expect(Company.count).to eq 100
    end
  end
end
