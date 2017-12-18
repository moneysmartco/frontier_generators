require 'rails_helper'

describe <%= model.engine_name.camelize %>::<%= policy_class_name %> do
  subject { <%= model.engine_name.camelize %>::<%= policy_class_name %>.new(user, target_user) }
  let(:target_user) { build(:ms_core_user) }

  context 'for a visitor' do
    let(:user) { nil }

    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context 'for a normal user' do
    let(:user) { build(:ms_core_user) }

    it { is_expected.not_to allow_action(:index) }
    it { is_expected.not_to allow_action(:show) }
    it { is_expected.not_to allow_action(:new) }
    it { is_expected.not_to allow_action(:create) }
    it { is_expected.not_to allow_action(:edit) }
    it { is_expected.not_to allow_action(:update) }
    it { is_expected.not_to allow_action(:destroy) }
  end

  context 'for an admin' do
    let(:user) { create(:ms_core_user, :admin) }

    it { is_expected.to allow_action(:index) }
    it { is_expected.to allow_action(:show) }
    it { is_expected.to allow_action(:new) }
    it { is_expected.to allow_action(:create) }
    it { is_expected.to allow_action(:edit) }
    it { is_expected.to allow_action(:update) }
    it { is_expected.to allow_action(:destroy) }
  end
end
