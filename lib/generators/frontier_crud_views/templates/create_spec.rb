require 'rails_helper'

feature 'Admin can create a new <%= model.name.as_constant %>', :js do
<%= render_with_indent(1, 'let!(:provider) { create(:ms_core_provider, :active) }') if model.acting_as? %>
<%= render_with_indent(1, Frontier::Spec::NestedModelLetSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AttributesSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AssociatedModelSetup.new(model).to_s) %>

  before do
    log_in_admin
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
    click_link('New <%= model.name.as_title %>')
  end

  scenario 'with valid data' do
<%= render_with_indent(2, Frontier::Spec::FeatureSpecAssignmentSet.new(model).to_s) %>
<% if model.acting_as? -%>
<%= render_with_indent(2, Frontier::Spec::FeatureSpecActingAs.new(model).to_s) %>
<% end -%>

    click_on('Save')

    expect(page).to have_content('<%= model.name.as_singular_with_spaces.capitalize %> was successfully created.')
    <%= model.name.as_singular %> = <%= model.engine_name.camelize + "::" if model.engine_object %><%= model.name.as_constant %>.order(created_at: :desc).first
<%= render_with_indent(2, Frontier::Spec::ObjectAttributesAssertion.new(model).to_s) %>
  end
end
