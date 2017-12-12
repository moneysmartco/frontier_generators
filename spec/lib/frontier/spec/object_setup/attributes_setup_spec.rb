require 'spec_helper'

RSpec.describe Frontier::Spec::ObjectSetup::AttributesSetup do

  describe "#to_s" do
    subject { Frontier::Spec::ObjectSetup::AttributesSetup.new(model).to_s }

    context "with no associations" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              name: {type: "string"},
            }
          }
        })
      end

      it { is_expected.to eq("let(:model_name_attributes) { attributes_for(:model_name) }") }
    end

    context "with associations" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: form_type},
              other_thing: {type: "belongs_to", form_type: "inline", show_on_form: false},
              name: {type: "string"},
            }
          }
        })
      end

      context "without nested attributes" do
        let(:form_type) { "select" }
        it { is_expected.to eq("let(:model_name_attributes) { attributes_for(:model_name) }") }
      end

      context "with nested attributes" do
        let(:form_type) { "inline" }
        let(:expected) do
          raw = <<STRING
let(:model_name_attributes) { attributes_for(:model_name) }
let(:address_attributes) { attributes_for(:address) }
STRING
          raw.rstrip
        end

        it { is_expected.to eq(expected) }
      end
    end

  end

end
