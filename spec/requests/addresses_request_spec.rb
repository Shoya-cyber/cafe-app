require 'rails_helper'

RSpec.describe "Addresses", type: :request do

  describe "GET /edit" do
    it "returns http success" do
      get "/addresses/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/addresses/update"
      expect(response).to have_http_status(:success)
    end
  end

end
