require 'spec_helper'

describe Frontier::Controller::LandingSpecPath do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::LandingSpecPath.new(model) }
    let(:model) do
      Frontier::Model.new({
        'user_document' => {
          engine_name: engine_name
        }
      })
    end

    context 'with an engine_name defined' do
      let(:engine_name) { 'bengine' }

      context 'when there are no namespaces or nested models' do
        it { is_expected.to eq('spec/controllers/bengine/pages_controller_spec.rb') }
      end
    end

    context 'without an engine_name defined' do
      let(:engine_name) { }

      context 'when there are no namespaces or nested models' do
        it { is_expected.to eq('spec/controllers/pages_controller_spec.rb') }
      end
    end
  end
end
