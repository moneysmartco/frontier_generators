class Frontier::Controller::LandingSpecPath

  include Frontier::ModelProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join([
      "app",
      "controllers",
      model.engine_name,
      'pages_controller_spec.rb'
    ].compact).to_s
  end

end
