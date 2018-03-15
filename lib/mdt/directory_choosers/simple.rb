require 'mdt-core'
require 'fileutils'
module MDT
  # A module containing all directory choosers
  module DirectoryChoosers
    # A class that implements simple directory choosers
    class Simple < MDT::DirectoryChoosers::Base
      # A method that defines a key for directory choosers class.
      # Returns:
      # * "simple"
      def self.key
        'simple'
      end

      # A method that defines keys for available directory choosers.
      # Returns:
      # * +["directory"]+
      def self.subkeys
        ['directory']
      end

      # A method that defines how to create a deploy directory with directory choosers.
      # Arguments:
      # * +key+ - a key identifier of a particular directory chooser
      # * +options+ - options for directory chooser as a Hash
      # Returns:
      # * Exit code for directory chooser +key+
      # More information:
      # * See README.md for detailed description of directory choosers
      def mkdir(key, options = {})
        case key
        when 'directory'
          if options['path']
            begin
              puts "Creating directory: #{options['path']}"
              FileUtils.mkdir_p(options['path'])
              0
            rescue
              1
            end
          else
            1
          end
        end
      end

      # A method that defines how to change working directory to a deploy directory with directory choosers.
      # Arguments:
      # * +key+ - a key identifier of a particular directory chooser
      # * +options+ - options for directory chooser as a Hash
      # Returns:
      # * Exit code for directory chooser +key+
      # More information:
      # * See README.md for detailed description of directory choosers
      def cd(key, options = {})
        case key
        when 'directory'
          if options['path']
            begin
              puts "Changing working directory to: #{options['path']}"
              FileUtils.cd(Dir[options['path']].first)
              0
            rescue
              1
            end
          else
            1
          end
        end
      end

      # A method that defines how to remove a deploy directory with directory choosers.
      # Arguments:
      # * +key+ - a key identifier of a particular directory chooser
      # * +options+ - options for directory chooser as a Hash
      # Returns:
      # * Exit code for directory chooser +key+
      # More information:
      # * See README.md for detailed description of directory choosers
      def rm(key, options = {})
        case key
        when 'directory'
          0
        end
      end
    end
  end
end