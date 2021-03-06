require 'spec_helper'

describe Frontier::Input::SelectFormAssociation do

  let(:input_implementation) { Frontier::Input::SelectFormAssociation.new(association) }
  let(:association) { Frontier::Association.new(build_model, name, options) }
  let(:name) { "association_name_id" }
  let(:options) { {} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    describe "providing additional options" do
      let(:expected_output) { "= f.association :association_name, collection: AssociationName.all, my_option: :jordan_rules" }
      let(:name) { "association_name_id" }
      let(:input_options) { {my_option: ":jordan_rules"} }

      it { is_expected.to eq(expected_output) }
    end

    describe "setting name of input" do
      context "with class_name declared" do
        let(:expected_output) { "= f.association :association_name, collection: Dong.all" }
        let(:options) { {class_name: "Dong"} }

        it { is_expected.to eq(expected_output) }
      end

      context "without class_name declared" do
        let(:expected_output) { "= f.association :association_name, collection: AssociationName.all" }

        context "when field_name includes _id already" do
          let(:name) { "association_name_id" }
          it { is_expected.to eq(expected_output) }
        end

        context "when field_name doesn't include _id" do
          let(:name) { "association_name" }
          it { is_expected.to eq(expected_output) }
        end
      end
    end
  end

end
