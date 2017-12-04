require 'spec_helper'

describe Frontier::Spec::NestedModelLetSetup do

  describe "#to_s" do
    subject { setup.to_s }
    let(:setup) { Frontier::Spec::NestedModelLetSetup.new(model) }
    let(:model) do
      Frontier::Model.new({user: {controller_prefixes: controller_prefixes}})
    end

    context "with no nested models" do
      let(:controller_prefixes) { [] }
      it { should eq("") }
    end

    context "with one nested model" do
      let(:controller_prefixes) { ["@site"] }
      it { should eq("let(:site) { create(:site) }") }
    end

    context "with two nested models" do
      let(:controller_prefixes) { ["@company", "@site"] }
      let(:expected) do
        raw = <<STRING
let(:site) { create(:site, company: company) }
let(:company) { create(:company) }
STRING
        raw.rstrip
      end


      it { should eq(expected) }
    end
  end

end
