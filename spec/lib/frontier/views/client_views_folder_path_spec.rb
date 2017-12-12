require 'spec_helper'

describe Frontier::Views::ClientViewsFolderPath do

  describe '#to_s' do
    subject { feature_spec_path.to_s }
    let(:feature_spec_path) { Frontier::Views::ClientViewsFolderPath.new(model) }
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
        it { should eq("app/views/bengine/pages") }
      end

      context "when there are namespaces" do
        let(:controller_prefixes) { ["admin"] }
        it { should eq("app/views/bengine/admin/pages") }
      end

      context "when there are nested models" do
        let(:controller_prefixes) { ["@client"] }
        it { should eq("app/views/bengine/client/pages") }
      end

      context "when there are both namespaces and nested models" do
        let(:controller_prefixes) { ["admin", "@client"] }
        it { should eq("app/views/bengine/admin/client/pages") }
      end
    end

    context 'withouth an engine_name defined' do
      let(:engine_name) { }

      context "when there are no namespaces or nested models" do
        let(:controller_prefixes) { nil }
        it { should eq("app/views/pages") }
      end

      context "when there are namespaces" do
        let(:controller_prefixes) { ["admin"] }
        it { should eq("app/views/admin/pages") }
      end

      context "when there are nested models" do
        let(:controller_prefixes) { ["@client"] }
        it { should eq("app/views/client/pages") }
      end

      context "when there are both namespaces and nested models" do
        let(:controller_prefixes) { ["admin", "@client"] }
        it { should eq("app/views/admin/client/pages") }
      end
    end
  end
end
