require 'spec_helper'

describe Frontier::Attribute::Validation do
  let(:attribute) { Frontier::Attribute.new(build_model, name, options) }

  describe "#as_implementation" do
    subject { Frontier::Attribute::Validation.new(attribute, key, args).as_implementation }
    let(:key)       { "presence" }
    let(:name)      { "field_name" }
    let(:options)   { {} }

    context "inclusion" do
      let(:key)  { "inclusion" }
      let(:args) { [1, 2] }
      it { is_expected.to eq("inclusion: TestModel::FIELD_NAME_VALUES") }
    end

    describe "including arguments" do
      context "when args are a hash" do
        context "with a single arg" do
          let(:args) { {greater_than: 1} }
          it { is_expected.to eq("presence: {greater_than: 1}") }
        end

        context "with many args" do
          let(:args) { {greater_than: 1, less_than: 100} }
          it { is_expected.to eq("presence: {greater_than: 1, less_than: 100}") }
        end
      end

      # EG:
      # attribute_name
      #   validates:
      #     presence: true
      context "when args are not a hash" do
        let(:args) { true }
        it { is_expected.to eq("presence: true") }
      end
    end
  end

  describe "#as_spec" do
    subject { Frontier::Attribute::Validation.new(attribute, key, args).as_spec }
    let(:name)      { "field_name" }
    let(:options)   { {} }
    let(:args)      { {} }

    context "validation is 'inclusion'" do
      let(:key)  { "inclusion" }
      let(:args) { [1, 2, 3] }
      it { is_expected.to eq("it { is_expected.to validate_inclusion_of(:field_name).in_array(TestModel::FIELD_NAME_VALUES) }") }
    end

    context "validation is 'presence'" do
      let(:key) { "presence" }
      it { is_expected.to eq("it { is_expected.to validate_presence_of(:field_name) }") }
    end

    context "type is something else" do
      let(:key) { "heroin" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

end
