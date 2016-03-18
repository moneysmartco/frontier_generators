class Frontier::Views::FeatureSpecPath

  include Frontier::ModelConfigurationProperty

  def to_s
    File.join(
      "spec",
      "features",
      *model_configuration.controller_prefixes.map(&:as_snake_case),
      model_configuration.model_name.pluralize
    ).to_s
  end

end