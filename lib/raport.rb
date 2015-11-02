require 'raport/engine'
require 'raport/configuration'

module Raport
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
    
    alias :config :configuration
  end
end
