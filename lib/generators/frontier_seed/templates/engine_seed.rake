return if Rails.env.production?

if defined?(FactoryBot)

  FactoryBot.create(:<%= model.engine_name %>_<%= model.name.as_plural %>)
  rake_output "<%model.engine_name.camelize %>::<%= model.name.as_plural %> has been created"

end
