require 'spec_helper'

RSpec.describe Frontier::Spec::ObjectSetup::AttributesHash do

  describe "#to_hash" do
    subject { Frontier::Spec::ObjectSetup::AttributesHash.new(model).to_hash }

    describe "omitting fields that are not on the form" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              name: {type: "string"},
              other_attribute: {type: "string", show_on_form: false},
            }
          }
        })
      end

      let(:expected) do
        {
          name: "model_name_attributes[:name]"
        }
      end

      it { is_expected.to eq(expected) }
    end

    context "with a simple set of attributes" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              name: {type: "string"},
              other_attribute: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        {
          name: "model_name_attributes[:name]",
          other_attribute: "model_name_attributes[:other_attribute]"
        }
      end

      it { is_expected.to eq(expected) }
    end

    context "with an association that is not nested" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              name: {type: "string"},
              other_attribute: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        {
          address_id: "address.id",
          name: "model_name_attributes[:name]",
          other_attribute: "model_name_attributes[:other_attribute]"
        }
      end

      it { is_expected.to eq(expected) }
    end

    context "with a shallow nested set of attributes" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
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
        {
          address_id: "address.id",
          other_address_attributes: {
            line_1: "other_address_attributes[:line_1]",
            state_id: "state.id"
          },
          name: "model_name_attributes[:name]"
        }
      end

      it { is_expected.to eq(expected) }
    end

    context "with a deeply nested set of attributes" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                type: "belongs_to",
                form_type: "inline",
                attributes: {
                  line_1: {type: "string"},
                  state: {
                    type: "belongs_to",
                    form_type: "inline",
                    attributes: {
                      name: {type: "string"}
                    }
                  }
                }
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        {
          address_id: "address.id",
          other_address_attributes: {
            line_1: "other_address_attributes[:line_1]",
            state_attributes: {
              name: "state_attributes[:name]"
            }
          },
          name: "model_name_attributes[:name]"
        }
      end

      it { is_expected.to eq(expected) }
    end
  end

end
