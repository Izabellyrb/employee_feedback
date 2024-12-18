# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackResponse do
  subject(:feedback_response) { build(:feedback_response) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:corporate_email) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:company_tenure) }
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:generation) }
    it { is_expected.to validate_presence_of(:company_level_0) }
    it { is_expected.to validate_presence_of(:directorate_level_1) }
    it { is_expected.to validate_presence_of(:management_level_2) }
    it { is_expected.to validate_presence_of(:coordination_level_3) }
    it { is_expected.to validate_presence_of(:area_level_4) }
    it { is_expected.to validate_presence_of(:response_date) }
    it { is_expected.to validate_presence_of(:interest_in_position) }
    it { is_expected.to validate_presence_of(:contribution) }
    it { is_expected.to validate_presence_of(:feedback) }
    it { is_expected.to validate_presence_of(:interaction_with_manager) }
    it { is_expected.to validate_presence_of(:clarity_about_career_opportunities) }
    it { is_expected.to validate_presence_of(:expectation_of_permanence) }
    it { is_expected.to validate_presence_of(:employee_net_promoter_score) }

    context "when email format is not valid" do
      subject(:feedback_response) { build(:feedback_response, email: "teste@") }

      it { expect(feedback_response).not_to be_valid }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:position) }
    it { is_expected.to belong_to(:function) }
    it { is_expected.to belong_to(:department) }
  end
end
