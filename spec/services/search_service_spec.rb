# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchService do
  let!(:feedback_response) { create(:feedback_response) }
  let!(:feedback_response2) { create(:feedback_response, name: "Jane") }
  let!(:feedback_response3) { create(:feedback_response, name: "Anne", location: "Poá") }

  describe "#call" do
    context "when no parameters are passed" do
      let(:result) { described_class.new({}, nil).call }

      it { expect(result.count).to eq(3) }
      it { expect(result.first).to eq(feedback_response3) }
      it { expect(result.last).to eq(feedback_response) }
    end

    context "when one parameter is passed" do
      subject(:result) { described_class.new({ location: "brasília" }, nil).call }

      it { expect(result.count).to eq(2) }
      it { expect(result.first).to eq(feedback_response2) }
      it { expect(result.last).to eq(feedback_response) }
    end

    context "when multiple parameters are passed" do
      subject(:result) { described_class.new({ name: "Jane", location: "brasília" }, nil).call }

      it { expect(result.count).to eq(1) }
      it { expect(result.first).to eq(feedback_response2) }
    end
  end
end
