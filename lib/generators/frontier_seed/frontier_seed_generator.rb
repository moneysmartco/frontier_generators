require_relative '../../frontier'

class FrontierSeedGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    if model.engine_object?
      template('engine_seed.rake', "db/seeds/development/#{model.name.as_plural}_seed.rb")
    else
      template('seed.rake', "db/seeds/development/#{model.name.as_plural}_seed.rb")
    end
  end

end
