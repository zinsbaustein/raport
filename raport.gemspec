$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "raport/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "raport"
  s.version     = Raport.version
  s.authors     = ["Michael Rüffer", "Dominic Breuker"]
  s.email       = ["michael.rueffer@hitfoxgroup.com", "dominic.breuker@hitfoxgroup.com"]
  s.homepage    = "https://forderungsdienstleister.com"
  s.summary     = "Report engine"
  s.description = "This gem gives your rails app the ability to create large data report, without influencing the performance of the app server."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "carrierwave", "~> 0.10"
  s.add_dependency "state_machines-activerecord", "~> 0.2.0"
  s.add_dependency "inherited_resources", "~>1.6.0"
  s.add_dependency "config", "~>1.0.0"
  s.add_dependency "delayed_job_active_record", "~>4.0.3"

  s.add_development_dependency "pg"
end
