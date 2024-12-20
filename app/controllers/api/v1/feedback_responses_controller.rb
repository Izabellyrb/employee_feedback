# frozen_string_literal: true

module Api
  module V1
    class FeedbackResponsesController < ApplicationController
      before_action :check_dataset_file, only: %i[create]

      def index
        feedback_responses = FeedbackResponse.order(created_at: :desc).page(params[:page]).per(10)
        render json: { meta: pagination_meta(feedback_responses), listagem: feedback_responses }
      end

      def create
        result = ImportService.new(dataset_file).run

        render json: { message: result[:message] }, status: result[:status]
      end

      private

      def dataset_file
        params[:dataset_file]
      end

      def check_dataset_file
        return if dataset_file.present? && dataset_file.content_type == "text/csv"

        render json: { message: I18n.t("activerecord.messages.file_missing") }, status: :bad_request
      end

      def pagination_meta(feedback_responses)
        {
          pagina_atual: feedback_responses.current_page,
          prox_pag: feedback_responses.next_page,
          pag_anterior: feedback_responses.prev_page,
          total_pags: feedback_responses.total_pages,
          total_items: feedback_responses.total_count
        }
      end
    end
  end
end
