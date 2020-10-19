# frozen_string_literal: true

require "rails_helper"

RSpec.describe UploadsController, type: :controller do
  let(:valid_attributes) { {name: "something.csv", url: "https://funky", user: User.first.id} }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      User.create!(email: "karim@test.com", username: "karim", password: "random123")
      Upload.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to have_http_status(302) # be_successful expects a HTTP Status code of 200
      # expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
    end
  end
end
