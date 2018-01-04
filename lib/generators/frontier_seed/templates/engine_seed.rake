return if Rails.env.production?

if defined?(FactoryBot)

  FactoryBot.create(:<%= model.engine_name %>_<%= model.name %>)
  rake_output "<%model.engine_name.camelize %>::<%= model.name %> has been created"

end
