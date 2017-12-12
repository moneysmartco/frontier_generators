require 'rails_helper'

describe <%= policy_class_name %> do
  subject { policy }
  let(:policy) { <%= policy_class_name %>.new(user, <%= model.name.as_singular %>) }
  let(<%= model.name.as_symbol %>) { create(<%= model.name.as_symbol %>) }

  describe <%= policy_class_name %>::Scope do
    let(:policy_scope) { <%= policy_class_name %>::Scope.new(user, scope) }
    let(:scope) { <%= model.name.as_constant %>.all }

    describe "#resolve" do
      subject { policy_scope.resolve }

      context "for an anonymous user" do
        let(:user) { nil }

        it "cannot see any users" do
          should be_empty
        end
      end

      context "for an admin" do
        let(:user) { build(:user, :admin) }

        it { is_expected.to include(create(<%= model.name.as_symbol %>)) }
      end

      context "for a member" do
        let(:user) { build(:user, :member) }

        it { is_expected.to include(create(<%= model.name.as_symbol %>)) }
      end
    end
  end

  context "for an anonymous user" do
    let(:user) { nil }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
      it { is_expected.to be_empty }
    end

    it_behaves_like "Policy without access to CRUD actions"
  end

  context "for an admin" do
    let(:user) { build(:user, :admin) }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
<% model.attributes.each do |attribute| -%>
      it { is_expected.to include(<%= attribute.as_field_name %>) }
<% end -%>
    end

    it_behaves_like "Policy with access to CRUD actions"
  end

  context "for a member" do
    let(:user) { build(:user, :member) }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
<% model.attributes.each do |attribute| -%>
      it { is_expected.to include(<%= attribute.as_field_name %>) }
<% end -%>
    end

    it_behaves_like "Policy without access to CRUD actions"
  end
end
