require 'spec_helper'

RSpec.describe Frontier::ControllerAction::DestroyAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::DestroyAction.new(model).to_s }
    let(:model) { build_model }

    let(:expected) do
      raw = <<-STRING
def destroy
  @test_model = find_test_model
  authorize(TestModel)
  @test_model.destroy

  respond_with(@test_model, location: admin_test_models_path)
end
STRING
      raw.rstrip
    end

    it { is_expected.to eq(expected) }
  end

end
