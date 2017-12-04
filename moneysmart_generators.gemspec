# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "moneysmart_generators"
  s.version     = "0.24.2"
  s.authors     = ["Benjamin Robinson"]
  s.email       = ["ben.robinson@moneysmart.co"]
  s.homepage    = "https://github.com/moneysmartco/moneysmart_generators"
  s.summary     = "Comprehensive generators for CRUD"
  s.description = <<-EOF
    Use in conjunction with the app builder (https://github.com/moneysmartco/ms_app_cutter)
    Along with the engine builder (https://github.com/moneysmartco/ms-engine-cutter)
    to quickly scaffold usable engines with an admin interface for models.
  EOF

  s.files         = Dir['README.md', 'lib/**/{*,.[a-z]*}']
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  # For differentiating between 'a' and 'an'
  s.add_dependency 'indefinite_article', [">= 0.2.4"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec_junit_formatter"
  s.add_development_dependency "byebug"
end
