require 'spec_helper'

RSpec.describe Frontier::Spec::ObjectSetup do

  describe '#to_s' do
    subject { Frontier::Spec::ObjectSetup.new(model).to_s }

    context "without nested models" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<STRING
let(:model_name_attributes) { FactoryBot.attributes_for(:model_name) }
let(:attributes) do
  {
    name: model_name_attributes[:name]
  }
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "with nested models" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
                type: "belongs_to",
                form_type: "inline",
                attributes: {
                  line_1: {type: "string"},
                  state: {type: "belongs_to", form_type: "select"}
                }
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<STRING
let(:model_name_attributes) { FactoryBot.attributes_for(:model_name) }
let(:other_address_attributes) { FactoryBot.attributes_for(:address) }
let!(:address) { FactoryBot.create(:address) }
let!(:state) { FactoryBot.create(:state) }
let(:attributes) do
  {
    address_id: address.id,
    other_address_attributes: {
      line_1: other_address_attributes[:line_1],
      state_id: state.id
    },
    name: model_name_attributes[:name]
  }
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

end
