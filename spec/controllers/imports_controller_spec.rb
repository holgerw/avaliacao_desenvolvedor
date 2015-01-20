require 'rails_helper'

RSpec.describe ImportsController, :type => :controller do

  describe 'POST create' do
    before(:each) do
      @file = Rack::Test::UploadedFile.new( Rails.root.join("spec/fixtures/dados.txt") , 'text/plain')
      Import.delete_all
      Purchase.delete_all
    end

    it 'persists the import' do
      post :create, import: { file: @file }
      expect(Import.count).to eq 1
    end

    it 'persists the imported purchases' do
      post :create, import: { file: @file }
      expect(Purchase.count).to eq 4
    end

    it 'redirects to the upload page' do
      post :create, import: { file: @file }
      expect(response).to redirect_to(new_import_path)
    end
  end

  describe 'GET new' do
    it 'loads the import history' do
      get :new
      expect( assigns(:import_history)) .to be_truthy
    end
  end

end