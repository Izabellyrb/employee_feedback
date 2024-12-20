# frozen_string_literal: true

class FeedbackResponse < ApplicationRecord
  validates :name, :email, :corporate_email, :location, :company_tenure, :gender, :generation, :company_level_0,
    :directorate_level_1, :management_level_2, :coordination_level_3, :area_level_4, :response_date,
    :interest_in_position, :contribution, :learning_and_development, :feedback, :interaction_with_manager,
    :clarity_about_career_opportunities, :expectation_of_permanence, :employee_net_promoter_score, presence: true

  validates :email, :corporate_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :department
  belongs_to :position
  belongs_to :function

  LIMIT = 10
end
