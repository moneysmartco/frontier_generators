class Frontier::Controller::LandingSpecPath

  include Frontier::ModelProperty

  def to_s
    File.join([
      'spec',
      'routing',
      'landing_page_routing_spec.rb'
    ].compact).to_s
  end

end
