require 'spec_helper'

describe Frontier::Association::FeatureSpecAssignment do

  describe '#to_s' do
    subject { Frontier::Association::FeatureSpecAssignment.new(association).to_s }
    let(:association) { Frontier::Association.new(build_model, name, options) }
    let(:name)        { 'association_name' }
    let(:options)     { {} }

    it { is_expected.to eq("select(association_name, from: 'Association name')") }
  end

end
