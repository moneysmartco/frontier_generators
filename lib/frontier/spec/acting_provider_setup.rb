class Frontier::Spec::ActingProviderSetup

  attr_reader :model

  def initialize(model)
    @model = model
  end

  # Generate the provider with the channel name for new objects
  # that are acting_as a ms_core product.

  def to_s
    if model.acting_as?

      raw = <<-STRING
let!(:provider) { create(:ms_core_provider, :active, channel_names: ['#{model.engine_name.titleize}']) }
STRING
      raw.rstrip
    end
  end

end
