class Frontier::Controller::ImplementationPath

  include Frontier::ModelProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join([
      "app",
      "controllers",
      model.engine_name,
      *model.controller_prefixes.map(&:as_snake_case),
      file_name
    ].compact).to_s
  end

private

  def file_name
    "#{model.name.as_plural}_controller.rb"
  end

end
