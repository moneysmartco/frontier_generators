class Frontier::UrlBuilder

  include Frontier::ModelProperty

  def index_path(show_nested_model_as_ivar: true)
    "#{engine_route}#{plural_resource_route_with_controller_prefixes}#{route_objects(show_member: false, show_nested_model_as_ivar: show_nested_model_as_ivar)}"
  end

  def new_path(show_nested_model_as_ivar: true)
    "#{engine_route}new_#{singular_resource_route_with_controller_prefixes}#{route_objects(show_member: false, show_nested_model_as_ivar: show_nested_model_as_ivar)}"
  end

  def edit_path(show_nested_model_as_ivar: true)
    "#{engine_route}edit_#{singular_resource_route_with_controller_prefixes}#{route_objects(show_member: true, show_nested_model_as_ivar: show_nested_model_as_ivar)}"
  end

  def delete_path(show_nested_model_as_ivar: true)
    "#{engine_route}#{singular_resource_route_with_controller_prefixes}#{route_objects(show_member: true, show_nested_model_as_ivar: show_nested_model_as_ivar)}"
  end

  def landing_path(show_nested_model_as_ivar: true)
    "#{engine_route}#{singular_resource_landing_route_with_controller_prefixes}#{route_objects(show_member: false, show_nested_model_as_ivar: show_nested_model_as_ivar)}"
  end

private

  # Namespaces do nothing, nested models add an ivar.
  def route_objects(show_member:, show_nested_model_as_ivar:)
    components = [
      *model.controller_prefixes.select(&:nested_model?).map {|cp| show_nested_model(cp, show_nested_model_as_ivar)},
      (model.name.as_singular if show_member)
    ].compact

    if components.any?
      "(#{components.join(", ")})"
    end
  end

  def engine_route
    if model.engine_object?
      "#{model.engine_name}."
    end
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resources_path
  def plural_resource_route_with_controller_prefixes
    resource_with_controller_prefixes(model.name.as_singular.pluralize)
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resource_path
  def singular_resource_route_with_controller_prefixes
    resource_with_controller_prefixes(model.name.as_singular)
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resource_landing_path
  def singular_resource_landing_route_with_controller_prefixes
    resource_with_controller_prefixes(model.name.as_singular, 'landing')
  end


  def show_nested_model(controller_prefix, show_nested_model_as_ivar)
    if show_nested_model_as_ivar
      controller_prefix.name
    else
      controller_prefix.name.sub("@", "")
    end
  end

  def resource_with_controller_prefixes(resource, landing=nil)
    [
      *model.controller_prefixes.map(&:as_snake_case),
      resource,
      landing,
      'path'
    ].compact.join('_')
  end


end
