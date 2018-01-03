class Frontier::Spec::FeatureSpecActingAs

  attr_reader :model

  def initialize(model)
    @model = model
  end

  # Render common field inputs if object is acting as a product from MsCore.
  def to_s
    raw = <<-STRING
fill_in('#{model.name.as_singular}[name_en]',        with: #{model.name.as_singular}_attributes[:name_en])
fill_in('#{model.name.as_singular}[description_en]', with: #{model.name.as_singular}_attributes[:description_en])
fill_in('#{model.name.as_singular}[hopoff_url_en]',  with: #{model.name.as_singular}_attributes[:hopoff_url_en])
within('.#{model.name.as_singular}_provider_id') do
  semantic_select(selector: '##{model.name.as_singular}_provider_id', value: provider.id.to_s)
end
STRING
    raw.rstrip
  end

end
