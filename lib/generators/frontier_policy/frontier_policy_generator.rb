require_relative '../../frontier'

class FrontierPolicyGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    if model.using_pundit? && !model.skip_ui? && !model.skip_policies?
      if model.engine_object?
        template 'engine/policy.rb', engine_policy_path
        template 'engine/policy_spec.rb', engine_policy_spec_path
      else
        template 'policy.rb', policy_path
        template 'policy_spec.rb', policy_spec_path
      end
    end
  end

  # Scaffold methods - called from within template

  def policy_class_name
    "#{model.name.as_constant}Policy"
  end

  private

  def policy_path
    template_filename = "#{model.name.as_singular}_policy.rb"
    File.join('app', 'policies', template_filename)
  end

  def policy_spec_path
    template_filename = "#{model.name.as_singular}_policy_spec.rb"
    File.join('spec', 'policies', template_filename)
  end

  def engine_policy_path
    template_filename = "#{model.name.as_singular}_policy.rb"
    File.join('app', 'policies', model.engine_name, template_filename)
  end

  def engine_policy_spec_path
    template_filename = "#{model.name.as_singular}_policy_spec.rb"
    File.join('spec', 'policies', model.engine_name, template_filename)
  end
end
