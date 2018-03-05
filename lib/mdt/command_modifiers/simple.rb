require 'mdt-core'
module MDT
  module CommandModifiers
    class Simple < MDT::CommandModifiers::Base
      def self.key
        'simple'
      end

      def self.subkeys
        ['env', 'sudo', 'generic']
      end

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