require_relative '../../frontier'

class FrontierLandingPageViewsGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model.skip_landing_page?
      [
        [model.view_paths.landing_path, 'landing.html.slim']
      ].each do |template_override, template_filename|
        template((template_override || template_filename),
                 File.join(Frontier::Views::ClientViewsFolderPath.new(model).to_s,
                           template_filename))
      end
    end
  end

  private

  def instance_actions
    @instance_actions ||= Frontier::Views::Index::InstanceActions.new(model)
  end

  def generate_feature_path(template_name, feature_name)
    feature_path = File.join(Frontier::Views::FeatureSpecPath.new(model).to_s, feature_name)
    template(template_name, feature_path)
  end
end
