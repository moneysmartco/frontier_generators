require 'spec_helper'

describe Frontier::Controller::ImplementationPath do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::ImplementationPath.new(model) }
    let(:model) do
      Frontier::Model.new({
        "user_document" => {
          controller_prefixes: controller_prefixes,
          engine_name: engine_name
        }
      })
    end

    context 'with an engine_name defined' do
      let(:engine_name) { 'bengine' }

      context "when there are no namespaces or nested models" do
        let(:controller_prefixes) { nil }
        it { should eq("app/controllers/bengine/user_documents_controller.rb") }
      end

      context "when there are namespaces" do
        let(:controller_prefixes) { ["admin"] }
        it { should eq("app/controllers/bengine/admin/user_documents_controller.rb") }
      end

      context "when there are nested models" do
        let(:controller_prefixes) { ["@client"] }
        it { should eq("app/controllers/bengine/client/user_documents_controller.rb") }
      end

      context "when there are both namespaces and nested models" do
        let(:controller_prefixes) { ["admin", "@client"] }
        it { should eq("app/controllers/bengine/admin/client/user_documents_controller.rb") }
      end
    end

    context 'without an engine_name defined' do
      let(:engine_name) { }

      context "when there are no namespaces or nested models" do
        let(:controller_prefixes) { nil }
        it { should eq("app/controllers/user_documents_controller.rb") }
      end

      context "when there are namespaces" do
        let(:controller_prefixes) { ["admin"] }
        it { should eq("app/controllers/admin/user_documents_controller.rb") }
      end

      context "when there are nested models" do
        let(:controller_prefixes) { ["@client"] }
        it { should eq("app/controllers/client/user_documents_controller.rb") }
      end

      context "when there are both namespaces and nested models" do
        let(:controller_prefixes) { ["admin", "@client"] }
        it { should eq("app/controllers/admin/client/user_documents_controller.rb") }
      end
    end
  end
end
