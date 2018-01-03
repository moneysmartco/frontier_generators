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
        it { is_expected.to eq("app/views/bengine/pages") }
      end
    end

    context 'withouth an engine_name defined' do
      let(:engine_name) { }

      context "when there are no namespaces or nested models" do
        let(:controller_prefixes) { nil }
        it { is_expected.to eq("app/views/pages") }
      end
    end
  end
end
