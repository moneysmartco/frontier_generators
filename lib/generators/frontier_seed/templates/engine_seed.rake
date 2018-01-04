require MsCore::Engine.root.join('lib/rake_output')

return if Rails.env.production?

if defined?(FactoryBot)

  FactoryBot.create(:<%= model.engine_name %>_<%= model.name.as_singular %>)
  rake_output "<%= model.engine_name.camelize %>::<%= model.name.as_singular %> has been created"

end
