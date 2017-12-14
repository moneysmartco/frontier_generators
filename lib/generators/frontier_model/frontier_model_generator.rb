require_relative '../../frontier'

class FrontierModelGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model.skip_seeds?
      # Generate seed files for the model
      generate('frontier_seed', ARGV[0])
    end

    unless model.skip_model?
      if model.engine_object? && model.engine_name.present?
        generate('migration', Frontier::MigrationStringBuilder.new(model).engine_to_s)
        template('engine/model.rb', "app/models/#{model.engine_name}/#{model.name.as_singular}.rb")
        template('engine/model_spec.rb', "spec/models/#{model.engine_name}/#{model.name.as_singular}_spec.rb")
      else
        generate('migration', Frontier::MigrationStringBuilder.new(model).to_s)
        template('model.rb', "app/models/#{model.name.as_singular}.rb")
        template('model_spec.rb', "spec/models/#{model.name.as_singular}_spec.rb")
      end
    end

    unless model.skip_factory?
      if model.engine_object? && model.engine_name.present?
        template('engine/factory.rb', "spec/factories/#{model.engine_name}_#{model.name.as_plural}.rb")
      else
        template('factory.rb', "spec/factories/#{model.name.as_plural}.rb")
      end
    end
  end
end
