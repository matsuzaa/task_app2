require 'rails_helper'

RSpec.describe "Borrows", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/borrows/index"
      expect(response).to have_http_status(:success)
    end
  end

end
