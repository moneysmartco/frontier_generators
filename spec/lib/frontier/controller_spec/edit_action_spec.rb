require 'spec_helper'

describe Frontier::ControllerSpec::EditAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::EditAction.new(model) }
    let(:model) do
      Frontier::Model.new({
        user: {
          controller_prefixes: controller_prefixes,
          attributes: {
            name: {type: "string"}
          }
        }
      })
    end

    context "with no nested models" do
      let(:controller_prefixes) { [] }

      let(:expected) do
        raw = <<STRING
describe 'GET edit' do
  subject { get :edit, id: user.id }
  let!(:user) { create(:user) }

  authenticated_as(:admin) do
    it { is_expected.to render_template(:edit) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end

    context "with nested models" do
      let(:controller_prefixes) { ["@company"] }

      let(:expected) do
        raw = <<STRING
describe 'GET edit' do
  subject { get :edit, company_id: company.id, id: user.id }
  let!(:user) { create(:user, company: company) }
  let(:company) { create(:company) }

  authenticated_as(:admin) do
    it { is_expected.to render_template(:edit) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
        raw.rstrip
      end

      it { is_expected.to eq(expected) }
    end
  end

end
