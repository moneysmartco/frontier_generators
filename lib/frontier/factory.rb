class Frontier::Factory

  include Frontier::ModelProperty

  def to_s
    raw = <<-STRING
FactoryBot.define do
  factory #{model.name.as_symbol} do
#{render_aligned_and_indented(2, "{", factoried_attributes)}

    trait :invalid do
#{render_aligned_and_indented(3, "nil", invalid_attributes)}
    end
  end
end
STRING
    raw.rstrip
  end

  def engine_to_s
    raw = <<-STRING
FactoryBot.define do
  factory :#{model.engine_name}_#{model.name.as_singular}, class: '#{model.engine_name.camelize}::#{model.name.as_constant}' do
#{render_aligned_and_indented(2, '{', acting_attributes) if model.acting_as? }
#{render_with_indent(2, translated_fields) if model.acting_as? }

#{render_aligned_and_indented(2, "{", factoried_attributes)}

    trait :invalid do
#{render_aligned_and_indented(3, "nil", invalid_attributes)}
    end
  end
end
STRING
    raw.rstrip
  end

private

  def render_aligned_and_indented(indents, token, content)
    aligned_content = Frontier::StringAligner.new(content, token).aligned.join("\n")
    render_with_indent(indents, aligned_content)
  end

  def factoried_attributes
    model.attributes.sort_by(&:name).map do |attribute|
      attribute.as_factory_declaration
    end
  end

  def translated_fields
    raw = <<-STRING
I18n.available_locales.each do |locale|
  sequence(('name_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Name.name }
  sequence(('description_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Lorem.sentence }
  sequence(('hopoff_url_'.concat(locale.to_s.tr('-', '_')).to_sym) { |_n| FFaker::Internet.http_url }
end
STRING
    raw.rstrip
  end

  def invalid_attributes
    model.attributes.sort_by(&:name).map do |attribute|
      "#{attribute.name} nil"
    end
  end

  def acting_attributes
    [
      "association :provider, factory: :ms_core_provider, channel_names: ['#{model.engine_name.titleize}']",
      "status 'draft'",
      'slug { FFaker::Internet.slug }',
    ]
  end

end
