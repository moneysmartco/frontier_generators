require 'spec_helper'

describe Frontier::FormHeader do

  let(:form_header) { Frontier::FormHeader.new(model) }
  let(:model) { Frontier::Model.new(attributes) }

  describe "#to_s" do
    subject { form_header.to_s }
    let(:attributes) do
      {
        model: {
          controller_prefixes: controller_prefixes
        }
      }
    end
    let(:controller_prefixes) { nil }

    context "when there are no namespaces or nested models" do
      it { is_expected.to eq("simple_form_for @model do |f|") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { [:namespace] }

      it { is_expected.to eq("simple_form_for [:namespace, @model] do |f|") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@nested_model", "@other_model"] }

      it { is_expected.to eq("simple_form_for [@nested_model, @other_model, @model] do |f|") }
    end

    context "when there are a mix of namespaces and nested models" do
      let(:controller_prefixes) { [:admin, "@nested_model", "@other_model"] }

      it { is_expected.to eq("simple_form_for [:admin, @nested_model, @other_model, @model] do |f|") }
    end

  end

end
