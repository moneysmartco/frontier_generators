class Frontier::FeatureSpec::TargetObjectLetStatement

  include Frontier::ModelProperty

  # Sets up the object that we are using in our spec and any other objects that are required
  # to use this object (like nested objects).
  #
  # Example: Normal object
  #
  # let!(:claim) { create(:claim) }
  #
  # Example: Nested object
  #
  # let!(:claim) { create(:claim, client: client) }
  # let(:client) { create(:client) }
  #
  # * The parent object (client) will be used in route generation in other parts of the feature spec.
  #
  def to_s
    [
      let_statement_for_resource(model.name.as_singular, model.controller_prefixes),
      let_statements_for_nested_resources
    ].select(&:present?).join("\n")
  end

private

  def let_statements_for_nested_resources
    Frontier::Spec::NestedModelLetSetup.new(model).to_s
  end

  def factory_arguments_for(controller_prefixes)
    nested_models = controller_prefixes.select(&:nested_model?)
    if nested_models.any?
      {nested_models.last.as_snake_case => nested_models.last.as_snake_case}
    else
      {}
    end
  end

  def let_statement_for_resource(resouce_name, controller_prefixes, has_bang: true)
    let_statement = Frontier::Spec::LetStatement.new(resouce_name, factory_bot_call(resouce_name, controller_prefixes))
    let_statement.to_s(has_bang: has_bang)
  end

  def factory_bot_call(resouce_name, controller_prefixes)
    factory = Frontier::FactoryBotSupport::Declaration.new("create", resouce_name)
    factory.to_s(factory_arguments_for(controller_prefixes))
  end

end
