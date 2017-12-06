require_relative "../../frontier"

class FrontierControllerGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model.skip_ui?
      template "controller.rb", Frontier::Controller::ImplementationPath.new(model).to_s
      template "controller_spec.rb", Frontier::Controller::SpecPath.new(model).to_s
    end

    unless model.skip_landing_page?
      template 'page_controller.rb', Frontier::Controller::LandingPath.new(model).to_s
      # template 'page_controller_spec.rb', Frontier::Controller::LandingSpecPath.new(model).to_s
    end
  end

protected

  # Scaffold methods - called from within template

  # Used in implementation and spec
  #
  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def controller_name
    Frontier::Controller::ClassName.new(model).to_s
  end

  # EG: Admin::DriversController < Admin::BaseController
  # EG: DriversController < ApplicationController
  def controller_name_and_superclass
    "#{controller_name} < #{controller_superclass_name}"
  end

private

  # EG: Admin::Users::BaseController
  # EG: Admin::BaseController
  # EG: ApplicationController
  def controller_superclass_name
    Frontier::Controller::SuperClassName.new(model).to_s
  end

end
