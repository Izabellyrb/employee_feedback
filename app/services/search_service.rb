# frozen_string_literal: true

class SearchService
  def initialize(permitted_params, page)
    @permitted_params = permitted_params
    @page = page
  end

  def call
    feedback_responses = FeedbackResponse

    if @permitted_params.present?
      @permitted_params.each do |key, value|
        feedback_responses = feedback_responses.where(key => value)
      end
    end

    feedback_responses.order(created_at: :desc).page(@page).per(FeedbackResponse::LIMIT)
  end
end
