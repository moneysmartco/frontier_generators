<% if model.engine_name? -%>
require_dependency '<%= "#{model.engine_name}/application_controller" %>'
<% end -%>

module <%= model.engine_name.camelize %>
  class PagesController < ApplicationController

    def landing; end
  end
end
