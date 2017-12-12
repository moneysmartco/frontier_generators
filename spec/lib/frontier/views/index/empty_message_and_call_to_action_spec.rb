require 'spec_helper'

describe Frontier::Views::Index::EmptyMessageAndCallToAction do

  describe "#to_s" do
    subject { empty_message.to_s }

    let(:empty_message) { Frontier::Views::Index::EmptyMessageAndCallToAction.new(model) }
    let(:model) do
      skip_ui_options = []
      skip_ui_options << "create" unless show_create

      Frontier::Model.new({
        user_setting: {
          authorization: "cancancan",
          skip_ui: skip_ui_options
        }
      })
    end

    context "when there is a new action" do
      let(:show_create) { true }
      let(:expected) do
        raw = <<-STRING
%p
  There are no user settings.
  - if can?(:new, UserSetting)
    = link_to("Add a user setting.", new_user_setting_path)
STRING
        raw.rstrip
end

      it { is_expected.to eq(expected) }
    end

    context "when there is no new action" do
      let(:show_create) { false }
      let(:expected) { "%p There are no user settings." }

      it { is_expected.to eq(expected) }
    end
  end

end
