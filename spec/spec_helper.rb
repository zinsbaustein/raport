ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'rspec/autorun'
# require "rails/all"
# require 'rspec/rails'
# require 'rspec/active_job'
# require 'factory_girl_rails'
require 'simplecov'

SimpleCov.start
Bundler.setup

require 'carrierwave'
require 'state_machines-activerecord'
require 'inherited_resources'
require 'delayed_job_active_record'

Rails.backtrace_cleaner.remove_silencers!
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  # config.use_transactional_fixtures = true
  # config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end