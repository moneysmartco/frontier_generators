require 'rails_helper'

module <%= model.engine_name.camelize %>
  describe <%= controller_name %> do

<% if model.show_index? -%>
<%= render_with_indent(2, Frontier::ControllerSpec::IndexAction.new(model).to_s) %>

<% end -%>
<% if model.show_create? -%>
<%= render_with_indent(2, Frontier::ControllerSpec::NewAction.new(model).to_s) %>

<%= render_with_indent(2, Frontier::ControllerSpec::CreateAction.new(model).to_s) %>

<% end -%>
<% if model.show_update? -%>
<%= render_with_indent(2, Frontier::ControllerSpec::EditAction.new(model).to_s) %>

<%= render_with_indent(2, Frontier::ControllerSpec::UpdateAction.new(model).to_s) %>

<% end -%>
<% if model.show_delete? -%>
<%= render_with_indent(2, Frontier::ControllerSpec::DestroyAction.new(model).to_s) %>

<% end -%>
  end
end
