module Raport
  class Configuration    
    attr_accessor :storage
    
    def storage
      @storage || :file
    end
  end
end