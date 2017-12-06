class Frontier::Controller::LandingPath

  include Frontier::ModelProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join([
      "app",
      "controllers",
      model.engine_name,
      'pages_controller.rb'
    ].compact).to_s
  end

end
