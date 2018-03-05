require 'mdt-core'
require 'fileutils'
module MDT
  module DirectoryChoosers
    class Simple < MDT::DirectoryChoosers::Base
      def self.key
        'simple'
      end

      def self.subkeys
        ['directory']
      end

      def mkdir(key, options = {})
        case key
        when 'directory'
          if options[:path]
            begin
              puts "Creating directory: #{options[:path]}"
              FileUtils.mkdir_p(options[:path])
              0
            rescue
              1
            end
          else
            1
          end
        end
      end

      def cd(key, options = {})
        case key
        when 'directory'
          if options[:path]
            begin
              puts "Changing working directory to: #{options[:path]}"
              FileUtils.cd(options[:path])
              0
            rescue
              1
            end
          else
            1
          end
        end
      end

      def rm(key, options = {})
        case key
        when 'directory'
          0
        end
      end
    end
  end
end