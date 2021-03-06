require 'spec_helper'

describe Frontier::Input::Attribute do

  let(:input_implementation) { Frontier::Input::Attribute.new(attribute) }
  let(:attribute) { Frontier::Attribute.new(build_model, name, options) }
  let(:name) { "attribute_name" }
  let(:options) { {} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    describe "using as: :date_picker" do
      [:datetime, :date].each do |attribute_type|
        context "when type is #{attribute_type}" do
          let(:options) { {type: attribute_type} }
          # Temporarily removed :date_picker till we implemenet our own.
          it { is_expected.to eq("= f.input :attribute_name") }
        end
      end
    end

    describe "providing additional options" do
      let(:input_options) { {my_option: ":jordan_rules"} }

      it { is_expected.to eq("= f.input :attribute_name, my_option: :jordan_rules") }
    end

    describe "attribute must be included in a given collection" do
      let(:options) { {validates: {inclusion: [1,2,3]} } }

      it { is_expected.to eq("= f.input :attribute_name, collection: TestModel::ATTRIBUTE_NAME_VALUES") }
    end
  end

end
