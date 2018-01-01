module <%= model.engine_name.camelize %>
  class <%= model.name.as_constant%>Decorator < Draper::Decorator
    delegate_all

    def hopoff_url
      if @object.hopoff_url.present?
        @object.hopoff_url
      else
        @object.hopoff_url_en
      end
    end
  end
end
