require 'spec_helper'

describe Frontier::Controller::ClassName do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::ClassName.new(model) }
    let(:model) do
      Frontier::Model.new({
        "user_document" => {
          controller_prefixes: controller_prefixes
        }
      })
    end

    context "when there are no namespaces or nested models" do
      let(:controller_prefixes) { nil }
      it { is_expected.to eq("UserDocumentsController") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { ["admin"] }
      it { is_expected.to eq("Admin::UserDocumentsController") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@client"] }
      it { is_expected.to eq("Client::UserDocumentsController") }
    end

    context "when there are both namespaces and nested models" do
      let(:controller_prefixes) { ["admin", "@client"] }
      it { is_expected.to eq("Admin::Client::UserDocumentsController") }
    end
  end

end
