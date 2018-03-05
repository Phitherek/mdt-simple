require 'mdt-core'
require 'fileutils'
module MDT
  module Fetchers
    class Simple < MDT::Fetchers::Base
      def self.key
        'simple'
      end

      def self.subkeys
        ['directory']
      end

      def fetch(key, options = {})
        case key
        when 'directory'
          if options[:path]
            begin
              puts "Fetching project data from directory: #{options[:path]}"
              FileUtils.cp_r(options[:path], '.')
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