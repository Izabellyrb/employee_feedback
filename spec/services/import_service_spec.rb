# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportService do
  describe ".run" do
    subject(:result) { described_class.new(file).run }

    let(:file) { file_fixture("data.csv") }

    context "when success" do
      before { result }

      it { expect(result).to be_truthy }
      it { expect(FeedbackResponse.count).to eq(5) }
    end

    context "when file has blank rows" do
      let(:file) { file_fixture("blank_data.csv") }

      it { expect(result[:status]).to eq :unprocessable_entity }
      it { expect(FeedbackResponse.count).to eq(0) }
    end

    context "when some error happens" do
      before do
        allow_any_instance_of(described_class).to receive(:run).and_raise(StandardError, "Erro")
      end

      it { expect { result }.to raise_error(StandardError) }
      it { expect(FeedbackResponse.count).to eq(0) }
    end
  end
end
