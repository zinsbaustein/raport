require 'rails/generators'

module Raport
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
 
      def copy_initializer_file
        copy_file "initializer.rb", "config/initializers/raport.rb"
      end
    end
  end
end