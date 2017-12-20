require 'rails_helper'

feature 'Admin can update an existing <%= model.name.as_constant %>', :js do
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AttributesSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AssociatedModelSetup.new(model).to_s) %>

  before do
    log_in_admin
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
    within_row(<%= model.name.as_singular %>.<%= model.primary_attribute.name %>) do
      click_link('Edit')
    end
  end

  scenario 'with valid data' do
<%= render_with_indent(2, Frontier::Spec::FeatureSpecAssignmentSet.new(model).to_s) %>

    page.execute_script("window.scrollTo(0, document.body.scrollHeight)")
    click_on('Save')

    expect(page).to have_content('<%= model.name.as_singular_with_spaces.capitalize %> was successfully updated.')
    <%= model.name.as_singular %>.reload
<%= render_with_indent(2, Frontier::Spec::ObjectAttributesAssertion.new(model).to_s) %>
  end

end
