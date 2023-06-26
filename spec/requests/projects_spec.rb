require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /not-found" do
    it "returns an error for a missing project" do
      get "/projects/not-found"
      expect(response).to have_http_status(302)
      expect(response).to redirect_to projects_path
    end

    it "displays a helpful flash message" do
      get "/projects/lochabar-road"
      message = "The project you were looking for could not be found!"
      expect(flash[:alert]).to eq message
    end
  end
end
