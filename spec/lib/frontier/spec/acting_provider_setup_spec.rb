require 'spec_helper'

RSpec.describe Frontier::Spec::ActingProviderSetup do

  describe '#to_s' do
    subject { Frontier::Spec::ActingProviderSetup.new(model).to_s }
    let(:model) do
      Frontier::Model.new(model_name: {
        acting_as: true,
        engine_name: 'test_engine',
      })
    end

    let(:expected) do
      raw = <<~STRING
let!(:provider) { create(:ms_core_provider, :active, channel_names: ['Test Engine']) }
STRING
      raw.strip
    end

    it { is_expected.to eq(expected) }
  end
end
