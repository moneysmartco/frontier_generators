class Frontier::Routes
  ROUTES_FILE_PATH = 'config/routes.rb'.freeze
end

require_relative 'routes/namespace'
require_relative 'routes/resource'
