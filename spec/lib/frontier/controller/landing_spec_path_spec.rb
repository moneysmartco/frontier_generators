require 'spec_helper'

describe Frontier::Controller::LandingSpecPath do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::LandingSpecPath.new(model) }
    let(:model) { Frontier::Model.new({model: {}}) }

    it { is_expected.to eq('spec/routing/landing_page_routing_spec.rb') }
  end
end
