require 'spec_helper'

RSpec.describe Frontier::Spec::LetStatement do

  describe "#to_s" do
    subject { Frontier::Spec::LetStatement.new("jordan", text).to_s(options) }

    let(:options) do
      {
        has_bang: has_bang,
        is_multiline: is_multiline
      }
    end

    let(:text)         { "rules" }
    let(:has_bang)     { false }
    let(:is_multiline) { false }

    describe "including a bang" do
      context "when has_bang" do
        let(:has_bang) { true }
        it { is_expected.to eq("let!(:jordan) { rules }") }
      end

      context "when !has_bang" do
        let(:has_bang) { false }
        it { is_expected.to eq("let(:jordan) { rules }") }
      end
    end

    describe "rendering as multiline" do
      context "when is_multiline" do
        let(:is_multiline) { true }
        let(:expected) do
          raw = <<TEXT
let(:jordan) do
  rules
end
TEXT
          raw.rstrip
        end

        context "and the given string has no indents" do
          it { is_expected.to eq(expected) }
        end

        context "and the given string has indents" do
          let(:text) { "\nrules" }
          it { is_expected.to eq(expected) }
        end

      end

      context "when !is_multiline" do
        let(:is_multiline) { false }
        it { is_expected.to eq("let(:jordan) { rules }") }
      end
    end
  end

end
