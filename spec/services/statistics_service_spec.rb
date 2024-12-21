# frozen_string_literal: true

require "rails_helper"

RSpec.describe StatisticsService do
  describe ".structure_stats" do
    subject(:result) { described_class.structure_stats }

    let(:department) { create(:department, name: "Administrativo") }
    let(:position) { create(:position, name: "Analista") }
    let(:function) { create(:function, name: "Profissional") }
    let(:feedback) { create(:feedback_response, department: department, position: position, function: function) }

    before do
      department
      position
      function
      feedback
    end

    it { expect(result[:areas]).to eq({ "Administrativo" => 1 }) }
    it { expect(result[:cargos]).to eq({ "Analista" => 1 }) }
    it { expect(result[:funcoes]).to eq({ "Profissional" => 1 }) }
  end

  describe ".location_stats" do
    subject(:result) { described_class.location_stats }

    let(:first_feedback_response) { create(:feedback_response, location: "Marília") }
    let(:second_feedback_response) { create(:feedback_response, location: "Maceió") }

    before do
      first_feedback_response
      second_feedback_response
    end

    it { expect(result).to eq({ "Maceió" => 1, "Marília" => 1 }) }
  end
end
