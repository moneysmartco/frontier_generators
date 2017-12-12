require 'spec_helper'

describe Frontier::FeatureSpec::VisitIndexMethod do

  describe '#method_name' do
    subject { visit_index_method.method_name }
    let(:visit_index_method) { Frontier::FeatureSpec::VisitIndexMethod.new(build_model) }

    it { is_expected.to eq("visit_index") }
  end

  describe "#to_s" do
    subject { visit_index_method.to_s }

    let(:visit_index_method) { Frontier::FeatureSpec::VisitIndexMethod.new(build_model) }

    let(:expected) do
      raw = <<STRING
def visit_index
  visit(admin_test_models_path)
end
STRING
      raw.rstrip
    end

    it { is_expected.to eq(expected) }
  end

end
