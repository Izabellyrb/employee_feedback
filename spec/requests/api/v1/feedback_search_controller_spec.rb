# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::FeedbackSearchController do
  before { create(:feedback_response) }

  describe "GET /api/v1/search" do
    it "returns search based on any query params" do
      create(:feedback_response, gender: "feminino", generation: "geração y")

      query = { gender: "feminino", generation: "geração y" }

      get "/api/v1/feedback_search/search", params: query

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["listagem"].size).to eq(1)
      expect(FeedbackResponse.count).to eq(2)
    end
  end

  describe "GET /api/v1/structure_stats" do
    it "returns a report of departments, functions and positions" do
      department = create(:department, name: "financeiro")
      create(:feedback_response, department_id: department.id)

      get "/api/v1/feedback_search/structure_stats"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["total"]["areas"]).to include("financeiro" => 1)
      expect(FeedbackResponse.count).to eq(2)
    end
  end

  describe "GET /api/v1/location_stats" do
    it "returns a report of locations" do
      create_list(:feedback_response, 3, location: "recife")

      get "/api/v1/feedback_search/location_stats"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["localidades"]["recife"]).to eq(3)
      expect(FeedbackResponse.count).to eq(4)
    end
  end
end
