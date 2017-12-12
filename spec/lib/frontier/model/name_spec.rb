require 'spec_helper'

describe Frontier::Model::Name do

  let(:name) { Frontier::Model::Name.new("test_model") }

  describe "#as_plural" do
    subject { name.as_plural }
    it { is_expected.to eq("test_models") }
  end

  describe "#as_singular" do
    subject { name.as_singular }
    it { is_expected.to eq("test_model") }
  end

  describe "#as_singular_with_spaces" do
    subject { name.as_singular_with_spaces }
    it { is_expected.to eq("test model") }
  end

  describe "#as_constant" do
    subject { name.as_constant }
    it { is_expected.to eq("TestModel") }
  end

  describe "#as_plural_ivar" do
    subject { name.as_plural_ivar }
    it { is_expected.to eq("@test_models") }
  end

  describe "#as_singular_ivar" do
    subject { name.as_singular_ivar }
    it { is_expected.to eq("@test_model") }
  end

  describe "#as_symbol" do
    subject { name.as_symbol }
    it { is_expected.to eq(":test_model") }
  end

  describe "#as_plural_symbol" do
    subject { name.as_plural_symbol }
    it { is_expected.to eq(":test_models") }
  end

  describe "#as_title" do
    subject { name.as_title }
    it { is_expected.to eq("Test Model") }
  end

end
