require 'spec_helper'

describe Frontier::Views::FeatureSpecPath do

  describe '#to_s' do
    subject { feature_spec_path.to_s }
    let(:feature_spec_path) { Frontier::Views::FeatureSpecPath.new(model) }
    let(:model) do
      Frontier::Model.new({
        "user_document" => {
          controller_prefixes: controller_prefixes
        }
      })
    end

    context "when there are no namespaces or nested models" do
      let(:controller_prefixes) { nil }
      it { is_expected.to eq("spec/features/user_documents") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { ["admin"] }
      it { is_expected.to eq("spec/features/admin/user_documents") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@client"] }
      it { is_expected.to eq("spec/features/client/user_documents") }
    end

    context "when there are both namespaces and nested models" do
      let(:controller_prefixes) { ["admin", "@client"] }
      it { is_expected.to eq("spec/features/admin/client/user_documents") }
    end
  end

end
