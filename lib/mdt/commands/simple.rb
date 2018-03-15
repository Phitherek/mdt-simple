require 'mdt-core'
require 'fileutils'
module MDT
  # A module containing all commands
  module Commands
    # A class that implements simple commands
    class Simple < MDT::Commands::Base
      # A method that defines a key for commands class.
      # Returns:
      # * "simple"
      def self.key
        'simple'
      end

      # A method that defines keys for available commands.
      # Returns:
      # * +["shell", "system", "mkdir", "cd", "cp", "mv", "rm", "ln", "chmod", "chown", "touch"]+
      def self.subkeys
        ['shell', 'system', 'mkdir', 'cd', 'cp', 'mv', 'rm', 'ln', 'chmod', 'chown', 'touch']
      end

      # A method that defines how to execute a command and how to apply command modifiers.
      # Arguments:
      # * +key+ - a key identifier of a particular command
      # * +modifiers+ - an array of command modifier configurations - each configuration is a Hash that includes modifier type and modifier options
      # * +options+ - options for command as a Hash
      # Returns:
      # * Exit code of command +key+
      # More information:
      # * See README.md for detailed description of commands
      def execute(key, modifiers = [], options = {})
        case key
        when 'shell'
          if options['command']
            options['shell'] ||= '/bin/bash'
            cmd = MDT::Helpers::Command.apply_command_modifiers(options['command'], modifiers)
            puts "Running shell command: #{options['shell']} #{options['args']} -c \"#{cmd}\""
            system("#{options['shell']} #{options['args']} -c \"#{cmd}\"")
            $?.exitstatus
          else
            1
          end
        when 'system'
          if options['command_string']
            cmd = MDT::Helpers::Command.apply_command_modifiers(options['command_string'], modifiers)
            puts "Running command: #{cmd}"
            system(cmd)
            $?.exitstatus
          else
            1
          end
        when 'mkdir'
          if options['path']
            begin
              if options['parents']
                puts "Creating directory with parents: #{options['path']}"
                FileUtils.mkdir_p(options['path'])
              else
                puts "Creating directory: #{options['path']}"
                FileUtils.mkdir(options['path'])
              end
              0
            rescue
              1
            end
          else
            1
          end
        when 'cd'
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
        when 'cp'
          if options['source_path'] && options['destination_path']
            begin
              if options['recursive']
                puts "Copying recursively from: #{options['source_path']} to: #{options['destination_path']}"
                FileUtils.cp_r(Dir[options['source_path']], Dir[options['destination_path']].first)
              else
                puts "Copying from: #{options['source_path']} to: #{options['destination_path']}"
                FileUtils.cp(Dir[options['source_path']], Dir[options['destination_path']].first)
              end
              0
            rescue
              1
            end
          else
            1
          end
        when 'mv'
          if options['source_path'] && options['destination_path']
            begin
              puts "Moving from: #{options['source_path']} to: #{options['destination_path']}"
              FileUtils.mv(Dir[options['source_path']], Dir[options['destination_path']].first)
            rescue
              1
            end
          else
            1
          end
        when 'rm'
          if options['path']
            begin
              if options['recursive'] && options['force']
                puts "Removing recursively with force: #{options['path']}"
                FileUtils.rm_rf(Dir[options['path']])
              elsif options['recursive']
                puts "Removing recursively: #{options['path']}"
                FileUtils.rm_r(Dir[options['path']])
              elsif options['force']
                puts "Removing with force: #{options['path']}"
                FileUtils.rm_f(Dir[options['path']])
              else
                puts "Removing: #{options['path']}"
                FileUtils.rm(Dir[options['path']])
              end
              0
            rescue
              1
            end
          else
            1
          end
        when 'ln'
          if options['destination_path'] && options['link_name']
            begin
             if options['symbolic'] && options['force']
               puts "Creating a symbolic link with force to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_sf(Dir[options['destination_path']], Dir[options['link_name']].first)
             elsif options['symbolic']
               puts "Creating a symbolic link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_s(Dir[options['destination_path']], Dir[options['link_name']].first)
             elsif options['force']
               puts "Creating a link with force to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_f(Dir[options['destination_path']], Dir[options['link_name']].first)
             else
               puts "Creating a link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln(Dir[options['destination_path']], Dir[options['link_name']].first)
             end
              0
            rescue
              1
            end
          else
            1
          end
        when 'chmod'
          if options['mode'] && options['destination_path']
            begin
              if options['recursive']
                puts "Changing mode recursively to: #{options['mode']} of: #{options['destination_path']}"
                FileUtils.chmod_R(options['mode'], Dir[options['destination_path']])
              else
                puts "Changing mode to: #{options['mode']} of: #{options['destination_path']}"
                FileUtils.chmod(options['mode'], Dir[options['destination_path']])
              end
            rescue
              1
            end
            0
          else
            1
          end
        when 'chown'
          if options['user'] && options['group'] && options['destination_path']
            begin
              if options['recursive']
                puts "Changing owner recursively to: #{options['user']}:#{options['group']} of: #{options['destination_path']}"
                FileUtils.chown_R(options['user'], options['group'], Dir[options['destination_path']])
              else
                puts "Changing owner to: #{options['user']}:#{options['group']} of: #{options['destination_path']}"
                FileUtils.chown(options['user'], options['group'], Dir[options['destination_path']])
              end
              0
            rescue
              1
            end
          else
            1
          end
        when 'touch'
          if options['path']
            begin
              puts "Touching: #{options['path']}"
              FileUtils.touch(Dir[options['path']])
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