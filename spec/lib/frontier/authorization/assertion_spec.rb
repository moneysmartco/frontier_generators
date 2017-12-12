require 'spec_helper'

describe Frontier::Authorization::Assertion do

  describe "#to_s" do
    subject { authorize_statement.to_s }
    let(:authorize_statement) { Frontier::Authorization::Assertion.new(model, action) }
    let(:model) { Frontier::Model.new(attributes) }
    let(:attributes) { {test_model: {authorization: authorization}}.stringify_keys }

    context "when using Pundit" do
      let(:action) { :index }
      let(:authorization) { "pundit" }

      it { is_expected.to eq("authorize(TestModel)") }
    end

    context "when using CanCanCan" do
      let(:authorization) { "cancancan" }

      context "and the action is index" do
        let(:action) { :index }
        it { is_expected.to eq("authorize!(:index, TestModel)") }
      end

      context "and the action is not index" do
        let(:action) { :show }
        it { is_expected.to eq("authorize!(:show, @test_model)") }
      end
    end
  end

end
