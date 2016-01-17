require 'rails_helper'

feature 'Admin can update an existing <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
  let!(:target_object) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    within_row(target_object.<%= model_configuration.primary_attribute.name %>) do
      click_link("Edit")
    end
  end

  scenario 'Admin updates user with valid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>)
<% model_configuration.attributes.each do |attribute| -%>
    <%= Frontier::FeatureSpecAssignment.new(attribute).to_s %>
<% end -%>

    submit_form

    expect(target_object.reload).to have_attributes(attributes)
  end

end
