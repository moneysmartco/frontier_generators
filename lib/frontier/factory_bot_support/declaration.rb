class Frontier::FactoryBotSupport::Declaration

  attr_reader :factory_object, :verb

  def initialize(verb, factory_object)
    @verb = verb
    @factory_object = factory_object
  end

  def to_s(factory_options={})
    "#{verb}(#{factory_body(factory_options)})"
  end

private

  def class_name
    case factory_object
    when Frontier::Model
      factory_object.name.as_singular
    when Frontier::Association
      factory_object.association_class.underscore
    else
      factory_object
    end
  end

  def factory_body(factory_options)
    factory_name = ":#{class_name}"
    formatted_factory_options = Frontier::HashSingleLineDecorator.new(factory_options).to_s

    [factory_name, formatted_factory_options].select(&:present?).join(", ")
  end

end
