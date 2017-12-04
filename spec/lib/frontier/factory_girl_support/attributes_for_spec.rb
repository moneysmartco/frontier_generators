require 'spec_helper'

RSpec.describe Frontier::FactoryBotSupport::AttributesFor do

  describe '#to_s' do
    subject { Frontier::FactoryBotSupport::AttributesFor.new(model_or_association).to_s }
    let(:model_or_association) { build_model }

    it { should eq("attributes_for(:test_model)") }
  end

end
