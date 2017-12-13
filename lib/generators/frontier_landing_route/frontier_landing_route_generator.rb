require_relative '../../frontier'

class FrontierLandingRouteGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  attr_reader :route_namespaces

  def scaffold
    unless model.skip_landing_page?
      line = 'localized_engine_scope do'
      # Dont keep adding the route if it exists already
      unless route_file_has_landing_route?
        gsub_file ROUTES_FILE_PATH, /(#{Regexp.escape(line)})/mi do |match|
          "#{match}\n    root to: 'pages#landing'"
        end
      end
    end
  end

  private

  def route_file_has_landing_route?
    File.readlines('config/routes.rb').grep(/root to: 'pages#landing'/).!empty?
  end

end
