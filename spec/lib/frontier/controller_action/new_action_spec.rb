require 'spec_helper'

RSpec.describe Frontier::ControllerAction::NewAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::NewAction.new(model_configuration).to_s }

    context "a model without any associations" do
      let(:model_configuration) { build_model_configuration }

      let(:expected) do
        raw = <<-STRING
def new
  @test_model = TestModel.new
  authorize(TestModel)
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "a model with shallow nested associations" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
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
def new
  @test_model = TestModel.new
  authorize(TestModel)
  @test_model.build_other_address
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "a model with deeply nested associations" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
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
def new
  @test_model = TestModel.new
  authorize(TestModel)
  @test_model.build_other_address
  @test_model.other_address.build_state
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

end
