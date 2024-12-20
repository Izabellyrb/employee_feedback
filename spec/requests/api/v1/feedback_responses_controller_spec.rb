# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::FeedbackResponsesController do
  describe "GET /api/v1/index" do
    it "returns all imported feedbacks" do
      create(:feedback_response)

      get "/api/v1/feedback_responses"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("demo001@teste.com.br", "brasília")
    end
  end

  describe "POST /api/v1/create" do
    context "when success" do
      let(:csv_file) { fixture_file_upload("data.csv", "text/csv") }

      before { post "/api/v1/feedback_responses", params: { dataset_file: csv_file } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include "Arquivo recebido com sucesso!" }
    end

    context "when failure" do
      context "when file is incomplete" do
        let(:blank_csv_file) { fixture_file_upload("blank_data.csv", "text/csv") }

        before { post "/api/v1/feedback_responses", params: { dataset_file: blank_csv_file } }

        it { expect(response).to have_http_status(:unprocessable_entity) }

        it { expect(response.body).to include "Erro ao processar - Arquivo contém campos em branco: nome, area. Processamento cancelado" }
      end

      context "when the file is not a csv" do
        let(:pdf_file) { fixture_file_upload("blank_data.csv", "pdf") }

        before { post "/api/v1/feedback_responses", params: { dataset_file: pdf_file } }

        it { expect(response).to have_http_status(:bad_request) }
        it { expect(response.body).to include "Insira um arquivo no formato csv." }
      end
    end
  end
end
