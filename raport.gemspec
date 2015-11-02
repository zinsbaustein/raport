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
  gem.test_files = Dir["test/**/*"]

  gem.add_dependency "rails", "~> 4.2.3"
  gem.add_dependency "railties", "~> 4.2.3"
  gem.add_dependency "carrierwave", "~> 0.10"
  gem.add_dependency "state_machines-activerecord", "~> 0.2.0"
  gem.add_dependency "inherited_resources", "~>1.6.0"
  gem.add_dependency "config", "~>1.0.0"
  gem.add_dependency "delayed_job_active_record", "~>4.0.3"

  gem.add_development_dependency "pg"
end