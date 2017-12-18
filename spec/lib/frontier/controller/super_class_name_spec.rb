require 'spec_helper'

describe Frontier::Controller::SuperClassName do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::SuperClassName.new(model) }
    let(:model) do
      Frontier::Model.new({
        "user_document" => {
          controller_prefixes: controller_prefixes
        }
      })
    end

    context "when there are no namespaces or nested models" do
      let(:controller_prefixes) { nil }
      it { is_expected.to eq("ApplicationController") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { ["admin"] }
      it { is_expected.to eq("MsCore::Admin::BaseController") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@client"] }
      it { is_expected.to eq("MsCore::Client::BaseController") }
    end

    context "when there are both namespaces and nested models" do
      let(:controller_prefixes) { ["admin", "@client"] }
      it { is_expected.to eq("MsCore::Admin::Client::BaseController") }
    end
  end

end
