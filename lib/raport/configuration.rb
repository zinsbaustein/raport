module Raport
  class Configuration    
    attr_accessor :storage, :formats
    
    def storage
      @storage || :file
    end
    
    def formats
      @formats || [:csv]
    end
  end
end