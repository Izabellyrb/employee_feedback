# frozen_string_literal: true

module Api
  module V1
    class FeedbackSearchController < FeedbackResponsesController
      def search
        feedback_responses = FeedbackResponse

        if params.present?
          feedback_params.each do |key, value|
            feedback_responses = feedback_responses.where(key => value)
          end
        end

        result = feedback_responses.order(created_at: :desc).page(params[:page]).per(10)
        render json: { meta: pagination_meta(result), listagem: result }
      end

      def structure_stats
        department_count = FeedbackResponse.joins(:department).group("departments.name").count
        position_count = FeedbackResponse.joins(:position).group("positions.name").count
        function_count = FeedbackResponse.joins(:function).group("functions.name").count

        render json: { total: { areas: department_count, cargos: position_count, funcoes: function_count } }
      end

      def location_stats
        location_count = FeedbackResponse.group(:location).count

        render json: { localidades: location_count }
      end

      private

      def feedback_params
        params.permit(
          :name, :email, :corporate_email, :location, :company_tenure, :gender,
          :generation, :company_level_0, :directorate_level_1, :management_level_2, :coordination_level_3,
          :department_level_4, :response_date, :interest_in_position, :comments_interest_in_position, :contribution,
          :comments_contribution, :learning_and_development, :comments_learning_and_development, :feedback,
          :comments_feedback, :interaction_with_manager, :comments_interaction_with_manager,
          :clarity_about_career_opportunities, :comments_clarity_about_career_opportunities, :expectation_of_permanence,
          :comments_expectation_of_permanence, :employee_net_promoter_score, :open_comments_enps, :department_id,
          :position_id, :function_id
        )
      end
    end
  end
end
