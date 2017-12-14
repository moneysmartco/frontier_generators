require 'spec_helper'

describe Frontier::Model do

  let(:model) { build_model }

  describe '#primary_attribute' do
    subject(:primary_attribute) { model.primary_attribute }

    let(:model) { Frontier::Model.new(model_options) }
    let(:model_options) do
      {
        test_model: {
          attributes: attributes
        }
      }
    end

    context 'when there is a primary attribute' do
      let(:attributes) do
        {
          primary_attribute: { primary: true },
          other_attribute: {}
        }
      end
      it 'returns the primary attribute' do
        expect(primary_attribute.name).to eq('primary_attribute')
      end
    end

    context 'when there is no primary attribute' do
      let(:attributes) do
        {
          primary_attribute: {},
          other_attribute: {}
        }
      end

      it 'returns the first attribute' do
        expect(primary_attribute.name).to eq('primary_attribute')
      end
    end
  end

  describe '#initialize' do

    describe 'assigning @authorization' do
      subject { model.authorization }
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { authorization: authorization } } }

      context 'when authorization is provided as a config option' do
        let(:authorization) { 'cancancan' }
        it { is_expected.to eq('cancancan') }
      end

      context 'when no authorization is provided as a config option' do
        let(:authorization) { nil }
        it { is_expected.to eq('pundit') }
      end
    end

    describe 'assigning @controller_prefixes' do
      subject { model.controller_prefixes.map(&:name) }
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { controller_prefixes: controller_prefixes } } }

      context 'when an array is passed through' do
        let(:controller_prefixes) { ['admin'] }
        it { is_expected.to eq(['admin']) }
      end

      context 'when some other non-nil type is passed through' do
        let(:controller_prefixes) { 'admin' }
        specify { expect { subject }.to raise_exception(ArgumentError) }
      end

      context 'when nil is passed through' do
        let(:controller_prefixes) { nil }
        it { is_expected.to eq([]) }
      end

    end

    describe 'assigns @engine_object' do
      subject { model.engine_object? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { engine_object: engine_object } } }

      context 'when engine_object is true' do
        let(:engine_object) { true }
        it { is_expected.to eq(true) }
      end

      context 'when engine_object is false' do
        let(:engine_object) { false }
        it { is_expected.to eq(false) }
      end

      context 'when engine_object is nil' do
        let(:engine_object) { nil }
        it { is_expected.to eq(false) }
      end
    end

    describe 'assigning @skip_factory' do
      subject { model.skip_factory? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_factory: skip_factory } } }

      context 'when skip_factory is true' do
        let(:skip_factory) { true }
        it { is_expected.to eq(true) }
      end

      context 'when skip_factory is false' do
        let(:skip_factory) { false }
        it { is_expected.to eq(false) }
      end

      context 'when skip_factory is nil' do
        let(:skip_factory) { nil }
        it { is_expected.to eq(false) }
      end
    end

    describe 'assigning @skip_model' do
      subject { model.skip_model? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_model: skip_model } } }

      context 'when skip_model is true' do
        let(:skip_model) { true }
        it { is_expected.to eq(true) }
      end

      context 'when skip_model is false' do
        let(:skip_model) { false }
        it { is_expected.to eq(false) }
      end

      context 'when skip_model is nil' do
        let(:skip_model) { nil }
        it { is_expected.to eq(false) }
      end
    end

    describe 'assigning @skip_seeds' do
      subject { model.skip_seeds? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_seeds: skip_seeds } } }

      context 'when skip_seeds is true' do
        let(:skip_seeds) { true }
        it { is_expected.to eq(true) }
      end

      context 'when skip_seeds is false' do
        let(:skip_seeds) { false }
        it { is_expected.to eq(false) }
      end

      context 'when skip_seeds is nil' do
        let(:skip_seeds) { nil }
        it { is_expected.to eq(false) }
      end
    end

    describe 'assigning @skip_policies' do
      subject { model.skip_policies? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_policies: skip_policies } } }

      context 'when skip_policies is true' do
        let(:skip_policies) { true }
        it { is_expected.to eq(true) }
      end

      context 'when skip_policies is false' do
        let(:skip_policies) { false }
        it { is_expected.to eq(false) }
      end

      context 'when skip_policies is nil' do
        let(:skip_policies) { nil }
        it { is_expected.to eq(false) }
      end
    end

    describe 'assigns @skip_landing_page' do
      subject { model.skip_landing_page? }

      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_landing_page: skip_landing_page } } }

      context 'when skip_landing_page is true' do
        let(:skip_landing_page) { true }
        it { is_expected.to eq(true) }
      end

      context 'when skip_landing_page is false' do
        let(:skip_landing_page) { false }
        it { is_expected.to eq(false) }
      end

      context 'when skip_landing_page is nil' do
        let(:skip_landing_page) { nil }
        it { is_expected.to eq(true) }
      end
    end

    describe 'hiding/showing UI elements' do
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { skip_ui: skip_ui } } }

      [
        [:show_index?, 'index'],
        [:show_delete?, 'delete'],
        [:show_create?, 'create'],
        [:show_update?, 'update'],
      ].each do |method_name, action|

        describe "##{method_name}" do
          subject { model.send(method_name) }

          context 'when skip_ui is true' do
            let(:skip_ui) { true }
            it { is_expected.to eq(false) }
          end

          context 'when skip_ui is false' do
            let(:skip_ui) { false }
            it { is_expected.to eq(true) }
          end

          context 'when skip_ui is nil (undefined)' do
            let(:skip_ui) { nil }
            it { is_expected.to eq(true) }
          end

          context 'when skip_ui is an array that includes index' do
            let(:skip_ui) { [action] }
            it { is_expected.to eq(false) }
          end

          context "when skip_ui is an array that doesn't include index" do
            let(:skip_ui) { ['to the windows, to the walls'] }
            it { is_expected.to eq(true) }
          end
        end
      end

    end

    describe 'assigns @engine_name' do
      subject { model.engine_name }
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { { test_model: { engine_name: engine_name } } }

      context 'when engine_name is present' do
        let(:engine_name) { 'Bengine' }

        it { is_expected.to eq('Bengine') }
      end

      context 'when engine_name is not present' do
        let(:engine_name) {}

        it { is_expected.to eq(nil) }
      end
    end
  end

  describe '#using_pundit?' do
    subject { model.using_pundit? }
    let(:model) { Frontier::Model.new(model_options) }
    let(:model_options) { { test_model: { authorization: authorization } } }

    context 'when authorization is pundit' do
      let(:authorization) { 'pundit' }
      it { is_expected.to eq(true) }
    end

    context 'when authorization is not pundit' do
      let(:authorization) { 'cancancan' }
      it { is_expected.to eq(false) }
    end

    context 'when no authorization is provided as a config option' do
      let(:authorization) { nil }
      it { is_expected.to eq(true) }
    end
  end

  describe '#view_paths' do
    subject { model.view_paths }
    let(:model) { Frontier::Model.new(model_options) }
    let(:model_options) { { test_model: { view_paths: view_paths } } }

    context 'when nil' do
      let(:view_paths) { nil }
      it { is_expected.to be_kind_of(Frontier::Model::ViewPaths) }
    end

    context 'when set' do
      let(:view_paths) { {} }
      it { is_expected.to be_kind_of(Frontier::Model::ViewPaths) }
    end
  end

end
