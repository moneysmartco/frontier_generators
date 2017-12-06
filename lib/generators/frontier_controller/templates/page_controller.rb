<% if model.engine_name? -%>
require_dependancy '<%= "#{model.engine_name}/application_controller" %>'
<% end -%>

module <%= model.name.as_plural.camelize %>
  class PagesController < ApplicationController

    def landing ;end
  end
end
