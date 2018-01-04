require_relative '../../frontier'

class FrontierSeedGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    if model.engine_object?
      template('engine_seed.rake', "lib/tasks/seeds/development/#{model.name.as_plural}.rake")
    else
      template('seed.rake', "lib/tasks/seeds/development/#{model.name.as_plural}.rake")
    end
  end

end
