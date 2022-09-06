require 'rails_helper'

RSpec.describe "Lends", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/lends/index"
      expect(response).to have_http_status(:success)
    end
  end

end
