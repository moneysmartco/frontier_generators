require 'spec_helper'

describe Frontier::Attribute do

  let(:attribute) { Frontier::Attribute.new(build_model, name, options) }
  let(:name) { "attribute_name" }
  let(:options) { {} }

  describe "#as_table_heading" do
    subject { attribute.as_table_heading }

    it { is_expected.to eq("Attribute Name") }
  end

  describe "#as_enum" do
    subject { attribute.as_enum }

    context "when field is not an enum" do
      let(:options) { {type: "string"} }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when field is an enum" do
      before { options[:type] = "enum" }

      context "enum_options is present" do
        before { options[:enum_options] = ["zero", "one"] }

        it { is_expected.to eq("enum attribute_name: {zero: 0, one: 1}") }
      end

      context "enum_options is blank" do
        before { options[:enum_options] = double(present?: false) }

        specify { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

  describe "#constants" do
    subject(:constants) { attribute.constants }

    context "with no constants" do
      it { is_expected.to be_empty }
    end

    context "with a constant provided by an inclusion validations" do
      let(:options) { {validates: {inclusion: [1, 2, 3]}} }

      it "returns a constant matching the inclusion matcher" do
        constant = constants.first
        expect(constant).to be_present
        expect(constant.name).to eq("TestModel::ATTRIBUTE_NAME_VALUES")
        expect(constant.values).to eq([1, 2, 3])
      end
    end
  end

  describe "#is_attribute?" do
    subject { attribute.is_attribute? }
    it { is_expected.to eq(true) }
  end

  describe "#is_association?" do
    subject { attribute.is_association? }
    it { is_expected.to eq(false) }
  end

  describe "#is_enum?" do
    subject { attribute.is_enum? }

    context "when field is not an enum" do
      let(:options) { {type: "string"} }
      it { is_expected.to eq(false) }
    end

    context "when field is an enum" do
      let(:options) { {type: "enum", enum_options: ["one", "two"]} }
      it { is_expected.to eq(true) }
    end
  end

  describe "#is_primary?" do
    subject { attribute.is_primary? }
    let(:options) { {primary: primary} }

    context "when primary is true" do
      let(:primary) { true }
      it { is_expected.to eq(true) }
    end

    context "when primary is false" do
      let(:primary) { false }
      it { is_expected.to eq(false) }
    end

    context "when primary is nil" do
      let(:primary) { nil }
      it { is_expected.to eq(false) }
    end
  end

  describe "#show_on_form?" do
    subject { attribute.show_on_form? }

    context "when show_on_form property is set" do
      context "when show_on_form is true" do
        let(:options) { {show_on_form: true} }
        it { is_expected.to eq(true) }
      end

      context "when show_on_form is false" do
        let(:options) { {show_on_form: false} }
        it { is_expected.to eq(false) }
      end
    end

    context "when show_on_form property is not set" do
      it { is_expected.to eq(true) }
    end
  end

  describe "#show_on_index?" do
    subject { attribute.show_on_index? }

    context "when show_on_index property is set" do
      context "when show_on_index is true" do
        let(:options) { {show_on_index: true} }
        it { is_expected.to eq(true) }
      end

      context "when show_on_index is false" do
        let(:options) { {show_on_index: false} }
        it { is_expected.to eq(false) }
      end
    end

    context "when show_on_index property is not set" do
      it { is_expected.to eq(true) }
    end
  end

  describe "#as_index_string" do
    subject { attribute.as_index_string }

    context "when attribute type is text" do
      before { allow(attribute).to receive(:type) { "text" } }

      it { is_expected.to eq "truncate(test_model.attribute_name, length: 30)" }
    end

    context "when attribute type is not text" do
      it { is_expected.to eq "test_model.attribute_name" }
    end
  end

  describe "#validations" do
    subject { attribute.validations }
    let(:options) { {validates: validates} }

    context "when there are no validations specified" do
      let(:validates) { {presence: true} }
      it "constructs a validation object" do
        validation = subject.first
        expect(validation).to be_present
        expect(validation).to be_kind_of(Frontier::Attribute::Validation)
        expect(validation.attribute).to eq(attribute)
        expect(validation.key).to eq("presence")
        expect(validation.args).to eq(true)
      end
    end

    context "when there are validations specified" do
      let(:validates) { nil }
      it { is_expected.to be_empty }
    end

  end

end
