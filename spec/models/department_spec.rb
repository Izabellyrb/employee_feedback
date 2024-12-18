# frozen_string_literal: true

require "rails_helper"

RSpec.describe Department do
  subject(:department) { build(:department) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
