require 'mdt-core'
require 'fileutils'
module MDT
  # A module containing all fetchers
  module Fetchers
    # A class that implements dummy fetchers
    class Simple < MDT::Fetchers::Base
      # A method that defines a key for fetchers class.
      # Returns:
      # * "simple"
      def self.key
        'simple'
      end

      # A method that defines keys for available fetchers.
      # Returns:
      # * +["directory"]+
      def self.subkeys
        ['directory']
      end

      # A method that defines how to fetch project contents to a deploy directory with fetchers.
      # Arguments:
      # * +key+ - a key identifier of a particular fetcher
      # * +options+ - options for fetchers as a Hash
      # Returns:
      # * Exit code for fetcher +key+
      # More information:
      # * See README.md for detailed description of fetchers
      def fetch(key, options = {})
        case key
        when 'directory'
          if options['path']
            begin
              puts "Fetching project data from directory: #{options['path']}"
              FileUtils.cp_r(Dir[options['path'] + '/*'], Dir['.'].first)
              0
            rescue
              1
            end
          else
            1
          end
        end
      end
    end
  end
end