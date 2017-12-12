require 'spec_helper'

describe Frontier::ControllerPrefix do

  let(:prefix) { Frontier::ControllerPrefix.new(name) }

  describe "#as_form_component" do
    subject { prefix.as_form_component }

    context "when namespace" do
      let(:name) { "model_name" }
      it { is_expected.to eq(":model_name") }
    end

    context "when nested resource" do
      let(:name) { "@model_name" }
      it { is_expected.to eq(name) }
    end
  end

  describe "#as_snake_case" do
    subject { prefix.as_snake_case }

    context "when namespace" do
      let(:name) { "model_name" }
      it { is_expected.to eq("model_name") }
    end

    context "when nested resource" do
      let(:name) { "@model_name" }
      it { is_expected.to eq("model_name") }
    end
  end

  describe "#as_route_object" do
    subject { prefix.as_route_object }

    context "when namespace" do
      let(:name) { "model_name" }
      it { is_expected.to eq(nil) }
    end

    context "when nested resource" do
      let(:name) { "@model_name" }
      it { is_expected.to eq("@model_name") }
    end
  end

  describe "#namespace?" do
    subject { prefix.namespace? }

    context "when namespace" do
      let(:name) { "model_name" }
      it { is_expected.to eq(true) }
    end

    context "when nested resource" do
      let(:name) { "@model_name" }
      it { is_expected.to eq(false) }
    end
  end

  describe "#nested_model?" do
    subject { prefix.nested_model? }

    context "when namespace" do
      let(:name) { "model_name" }
      it { is_expected.to eq(false) }
    end

    context "when nested resource" do
      let(:name) { "@model_name" }
      it { is_expected.to eq(true) }
    end
  end

end
