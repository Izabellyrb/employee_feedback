# frozen_string_literal: true

require "rails_helper"

RSpec.describe AreaInfoService do
  describe ".populate" do
    let(:row) do
      { area: "comercial",
        cargo: "estagiário",
        funcao: "profissional" }
    end

    before { described_class.populate(row) }

    it { expect(Department.count).to eq(1) }
    it { expect(Function.count).to eq(1) }
    it { expect(Position.count).to eq(1) }
  end
end
