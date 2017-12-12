require 'spec_helper'

RSpec.describe Frontier::ControllerAction::EditAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::EditAction.new(model).to_s }

    context "a model without any associations" do
      let(:model) { build_model }
      let(:expected) do
        raw = <<-STRING
def edit
  @test_model = find_test_model
  authorize(TestModel)
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end

    context "a model with shallow nested associations" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
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
        raw = <<-STRING
def edit
  @test_model = find_test_model
  authorize(TestModel)
  if @test_model.other_address.blank?
    @test_model.build_other_address
  end
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end

    context "a model with deeply nested associations" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
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
        raw = <<-STRING
def edit
  @test_model = find_test_model
  authorize(TestModel)
  if @test_model.other_address.blank?
    @test_model.build_other_address
    @test_model.other_address.build_state
  end
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end

    context "a model with a nested association that has multiple nested associations" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
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
                  },
                  contact_person: {
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
        raw = <<-STRING
def edit
  @test_model = find_test_model
  authorize(TestModel)
  if @test_model.other_address.blank?
    @test_model.build_other_address
    @test_model.other_address.build_state
    @test_model.other_address.build_contact_person
  end
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end
  end

end
