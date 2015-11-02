module Raport
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 1
    TINY  = 2
    PRE   = 'pre'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end
