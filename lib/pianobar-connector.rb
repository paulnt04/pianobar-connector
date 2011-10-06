require "pianobar-connector/version"
require 'rbconfig'

module Pianobar
  class Connector
    def initialize(params={})
      # Parameters for starting
    end

    def set_volume(nextVolume)
      case Config::CONFIG['host_os']
      when /darwin/
        case nextVolume
        when /\d+/
          volume = nextVolume.to_i
        when /max(imum)?/i
          volume = 10
        when /min(imum)?/i
          volume = 0
        else
          volume = false
        end
        if volume
          %x[osascript -e 'set Volume #{volume}']
          if $?.success?
             return "Volume has been set to #{volume}."
          else
           return "There was an error setting the volume."
          end
        else
          return "There was an error with your volume. Please use [0-10/max/min]"
        end
      else
        return "This option is not yet supported in this OS"
      end
    end
  end
end
