require_relative "../frontier_scaffold/lib/model_configuration.rb"

class FrontierCrudViewsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration.new(ARGV[0])

    [
      "index.html.haml",
      "_form.html.haml",
      "new.html.haml",
      "edit.html.haml"
    ].each do |template_filename|
      template template_filename, File.join(generate_base_path, template_filename)
    end

    plural = model_configuration.model_name.pluralize
    generate_feature_path("index_spec.rb", "admin_index_#{plural}_spec.rb")
    generate_feature_path("delete_spec.rb", "admin_delete_#{plural}_spec.rb")
    generate_feature_path("create_spec.rb", "admin_create_#{plural}_spec.rb")
    generate_feature_path("update_spec.rb", "admin_update_#{plural}_spec.rb")

    # This file contains helpers that are required for the above specs
    filename = "feature_attributes_support.rb"
    template(filename, File.join("spec", "support", filename))
  end

private

  def generate_base_path
    File.join("app", "views", *model_configuration.namespaces, model_configuration.model_name.pluralize)
  end

  def generate_feature_path(template_name, feature_name)
    template(template_name, "spec/features/admin/#{feature_name}")
  end

end