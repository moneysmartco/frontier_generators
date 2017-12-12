require 'spec_helper'

RSpec.describe Frontier::FactoryBotSupport::Declaration do

  describe '#to_s' do
    subject { factory_declaration.to_s }
    let(:factory_declaration) { Frontier::FactoryBotSupport::Declaration.new("build", factory_object) }

    describe "generating factory name" do
      context "with a Frontier::Model" do
        let(:factory_object) { build_model }
        it { is_expected.to eq("build(:test_model)") }
      end

      context "with a Frontier::Association" do
        let(:factory_object) { Frontier::Association.new(build_model, name, options) }
        let(:name) { "association_name" }
        let(:options) { {class_name: class_name} }

        context "without class name" do
          let(:class_name) { nil }
          it { is_expected.to eq("build(:association_name)") }
        end

        context "with class name" do
          let(:class_name) { "new_class_name" }
          it { is_expected.to eq("build(:new_class_name)") }
        end
      end

      context "with a string" do
        let(:factory_object) { "yolotronix" }
        it { is_expected.to eq("build(:yolotronix)") }
      end
    end

    describe "providing additional_options" do
      let(:factory_object) { "yolotronix" }

      context "with no options" do
        subject { factory_declaration.to_s }
        it { is_expected.to eq("build(:yolotronix)") }
      end

      context "with some options" do
        subject { factory_declaration.to_s(options) }
        let(:options) do
          {
            one: '"two"',
            three: :four
          }
        end

        it { is_expected.to eq("build(:yolotronix, one: \"two\", three: :four)") }
      end
    end
  end

end
