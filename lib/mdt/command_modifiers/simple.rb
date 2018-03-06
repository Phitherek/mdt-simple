require 'mdt-core'
module MDT
  # A module containing all command modifiers
  module CommandModifiers
    # A class that implements simple command modifiers
    class Simple < MDT::CommandModifiers::Base
      # A method that defines a key for command modifiers class.
      # Returns:
      # * "simple"
      def self.key
        'simple'
      end

      # A method that defines keys for available command modifiers.
      # Returns:
      # * +["env", "sudo", "generic"]+
      def self.subkeys
        ['env', 'sudo', 'generic']
      end

      # A method that defines how to prepend command modifiers to commands.
      # Arguments:
      # * +key+ - a key identifier of a particular command modifier
      # * +command+ - a command to apply command modifier on
      # * +options+ - options for modifier as a Hash
      # Returns:
      # * A value of +command+ modified with +key+ command modifier
      # More information:
      # * See README.md for detailed description of command modifiers
      def prepend(key, command, options = {})
        case key
        when 'env'
          if options['name'] && options['value']
            "#{options['name']}=#{options['value']} #{command}"
          else
            command
          end
        when 'sudo'
          "sudo #{options['args']} #{command}"
        when 'generic'
          if options['modifier_str']
            "#{options['modifier_str']} #{command}"
          else
            command
          end
        end
      end
    end
  end
end