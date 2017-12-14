require 'rails_helper'

module <%= model.engine_name.camelize %>
  describe <%= model.name.as_constant %> do
<% model.attributes.sort_by(&:name).select(&:validation_required?).each do |attribute| -%>

    describe '@<%= attribute.name %>' do
<% attribute.validations.each do |validation| -%>
<%= render_with_indent(3, validation.as_spec) %>
<% end -%>
    end
<% end -%>
  end
end
