require 'raport/concerns/controllers/reportify'

module Raport
  class Engine < ::Rails::Engine
    isolate_namespace Raport
    
    config.to_prepare do
      ApplicationController.helper(Raport::ApplicationHelper)
    end
      
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
