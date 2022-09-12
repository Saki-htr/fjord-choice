require 'rails_helper'

RSpec.describe "UserAssignedIssues", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/user_assigned_issues/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/user_assigned_issues/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
