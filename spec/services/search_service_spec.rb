# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchService do
  let(:feedback_response) { create(:feedback_response) }
  let(:second_feedback_response) { create(:feedback_response, name: "Jane") }
  let(:third_feedback_response) { create(:feedback_response, name: "Anne", location: "Poá") }

  before do
    feedback_response
    second_feedback_response
    third_feedback_response
  end

  describe "#call" do
    context "when no parameters are passed" do
      let(:result) { described_class.new({}, nil).call }

      it { expect(result.count).to eq(3) }
      it { expect(result.first).to eq(third_feedback_response) }
      it { expect(result.last).to eq(feedback_response) }
    end

    context "when one parameter is passed" do
      subject(:result) { described_class.new({ location: "brasília" }, nil).call }

      it { expect(result.count).to eq(2) }
      it { expect(result.first).to eq(second_feedback_response) }
      it { expect(result.last).to eq(feedback_response) }
    end

    context "when multiple parameters are passed" do
      subject(:result) { described_class.new({ name: "Jane", location: "brasília" }, nil).call }

      it { expect(result.count).to eq(1) }
      it { expect(result.first).to eq(second_feedback_response) }
    end
  end
end
