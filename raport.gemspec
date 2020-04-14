$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "raport/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "raport"
  gem.version     = Raport.version
  gem.authors     = ["Michael Rüffer", "Dominic Breuker"]
  gem.email       = ["michael.rueffer@hitfoxgroup.com", "dominic.breuker@hitfoxgroup.com"]
  gem.homepage    = "https://github.com/HitFox/raport"
  gem.summary     = "Report engine"
  gem.description = "This gem gives your rails app the ability to create large data reports, without influencing the performance of the app server."
  gem.license     = "MIT"

  gem.files = Dir["{app,config,db,lib}/**/*", "{lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  gem.test_files = Dir["spec/**/*"]
  
  gem.required_ruby_version = '~> 2.3'
  gem.add_dependency "rails", ">= 5.0"
  gem.add_dependency "railties", ">= 5.0"
  gem.add_dependency "carrierwave", ">= 0.3"
  gem.add_dependency "state_machines-activerecord", ">= 0.4"

  gem.add_development_dependency "pg"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "rspec-activejob"
  gem.add_development_dependency 'factory_girl_rails'
end
