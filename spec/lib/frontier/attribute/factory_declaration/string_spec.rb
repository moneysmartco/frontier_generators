require 'spec_helper'

describe Frontier::Attribute::FactoryDeclaration::String do

  describe "#to_s" do
    subject { Frontier::Attribute::FactoryDeclaration::String.new(attribute).to_s }
    let(:attribute) { Frontier::Attribute.new(build_model, name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {type: "string"} }

    context "attribute name contains city" do
      let(:name) { "city" }
      it { is_expected.to eq("FFaker::AddressAU.city") }
    end

    context "attribute name contains email" do
      let(:name) { "field_email" }
      it { is_expected.to eq("FFaker::Internet.email") }
    end

    context "attribute name contains fax" do
      let(:name) { "field_fax" }
      it { is_expected.to eq("FFaker::PhoneNumberAU.phone_number") }
    end

    context "attribute name contains line_1" do
      let(:name) { "line_1" }
      it { is_expected.to eq("FFaker::AddressAU.street_address") }
    end

    context "attribute name contains line_2" do
      let(:name) { "line_2" }
      it { is_expected.to eq("FFaker::AddressAU.secondary_address") }
    end

    context "attribute name contains first_name" do
      let(:name) { "field_first_name" }
      it { is_expected.to eq("FFaker::Name.first_name") }
    end

    context "attribute name contains last_name" do
      let(:name) { "field_last_name" }
      it { is_expected.to eq("FFaker::Name.last_name") }
    end

    context "attribute name contains name" do
      let(:name) { "field_name" }
      it { is_expected.to eq("FFaker::Name.name") }
    end

    context "attribute name contains number" do
      let(:name) { "field_number" }
      it { is_expected.to eq("FFaker::PhoneNumberAU.phone_number") }
    end

    context "attribute name contains post_code" do
      let(:name) { "post_code" }
      it { is_expected.to eq("FFaker::AddressAU.postcode") }
    end

    context "attribute name contains postcode" do
      let(:name) { "postcode" }
      it { is_expected.to eq("FFaker::AddressAU.postcode") }
    end

    context "attribute name contains suburb" do
      let(:name) { "suburb" }
      it { is_expected.to eq("FFaker::AddressAU.suburb") }
    end

    context "attribute name contains surname" do
      let(:name) { "field_surname" }
      it { is_expected.to eq("FFaker::Name.last_name") }
    end

    context "attribute name doesn't contain any of the above matches" do
      let(:name) { "field" }
      it { is_expected.to eq("FFaker::Lorem.sentence") }
    end
  end

end
