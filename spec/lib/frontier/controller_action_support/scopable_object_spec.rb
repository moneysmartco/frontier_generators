require 'spec_helper'

RSpec.describe Frontier::ControllerActionSupport::ScopableObject do

  describe "#to_s" do
    subject { Frontier::ControllerActionSupport::ScopableObject.new(model).to_s }
    let(:model) do
      Frontier::Model.new({
        "test_model" => {controller_prefixes: controller_prefixes}
      })
    end

    describe "model with no namespaces or nested models" do
      let(:controller_prefixes) { nil }

      it { is_expected.to eq("TestModel") }
    end

    describe "model with a namespace" do
      let(:controller_prefixes) { ["admin"] }

      it { is_expected.to eq("TestModel") }
    end

    describe "model with a nested model" do
      let(:controller_prefixes) { ["@client"] }

      it { is_expected.to eq("@client.test_models") }
    end

    describe "model with multiple nested model" do
      let(:controller_prefixes) { ["@client", "@doge"] }

      it { is_expected.to eq("@doge.test_models") }
    end
  end

end
