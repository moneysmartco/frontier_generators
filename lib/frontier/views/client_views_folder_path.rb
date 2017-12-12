class Frontier::Views::ClientViewsFolderPath

  include Frontier::ModelProperty

  def to_s
    File.join([
      'app',
      'views',
      model.engine_name,
      'pages'
    ].compact).to_s
  end

end
