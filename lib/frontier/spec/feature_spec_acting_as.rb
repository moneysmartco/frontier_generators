class Frontier::Spec::FeatureSpecActingAs

  attr_reader :model

  def initialize(model)
    @model = model
  end

  # Render common field inputs if object is acting as a product from MsCore.
  def to_s
    raw = <<-STRING
fill_in('#{model.name.as_singular}[name_en]',        with: #{model.name.as_singular}_attributes[:name])
fill_in('#{model.name.as_singular}[description_en]', with: #{model.name.as_singular}_attributes[:description])
fill_in('#{model.name.as_singular}[hopoff_url_en]',  with: #{model.name.as_singular}_attributes[:hopoff_url])
within('.#{model.name.as_singular}_provider_id') do
  select_from_semantic_select_menu(selector: '##{model.name.as_singular}_provider_id', value: provider.id)
end
STRING
    raw.rstrip
  end

end
