require_dependency '<%= model.engine_name %>/application_controller'

module <%= model.engine_name.camelize %>
  module Admin
    class <%= controller_name_and_superclass %>
      respond_to :js, :html

<% if model.show_index? -%>
<%= render_with_indent(3, Frontier::ControllerAction::IndexAction.new(model).to_s) %>

<% end -%>
<% if model.show_create? -%>
<%= render_with_indent(3, Frontier::ControllerAction::NewAction.new(model).to_s) %>

<%= render_with_indent(3, Frontier::ControllerAction::CreateAction.new(model).to_s) %>

<% end -%>
<% if model.show_update? -%>
<%= render_with_indent(3, Frontier::ControllerAction::EditAction.new(model).to_s) %>

<%= render_with_indent(3, Frontier::ControllerAction::UpdateAction.new(model).to_s) %>

<% end -%>
<% if model.show_delete? -%>
<%= render_with_indent(3, Frontier::ControllerAction::DestroyAction.new(model).to_s) %>

<% end -%>
<% if model.show_create? || model.show_update? || model.show_delete? -%>
      private

<%= render_with_indent(3, Frontier::ControllerAction::StrongParamsMethod.new(model).to_s) %>

<%= render_with_indent(3, Frontier::ControllerAction::FindMethod.new(model).to_s) %>

<% end -%>
    end
  end
end
