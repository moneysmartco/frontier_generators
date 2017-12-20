class Frontier::FactoryBotSupport::AttributesFor

  attr_reader :model_or_association

  def initialize(model_or_association)
    @model_or_association = model_or_association
  end

  def to_s
    if model_or_association.respond_to?(:engine_object) && model_or_association.engine_object?
      Frontier::FactoryBotSupport::EngineDeclaration.new("attributes_for", model_or_association, model_or_association).to_s
    else
      Frontier::FactoryBotSupport::Declaration.new("attributes_for", model_or_association).to_s
    end
  end

end
