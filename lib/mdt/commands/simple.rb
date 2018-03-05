require 'mdt-core'
require 'fileutils'
module MDT
  module Commands
    class Simple < MDT::Commands::Base
      def self.key
        'simple'
      end

      def self.subkeys
        ['shell', 'system', 'mkdir', 'cd', 'cp', 'mv', 'rm', 'ln', 'chmod', 'chown', 'touch']
      end

      def execute(key, modifiers = [], options = {})
        case key
        when 'shell'
          if options['command']
            options['shell'] ||= '/bin/bash'
            cmd = MDT::Helpers::Command.apply_command_modifiers(options['command'], modifiers)
            puts "Running shell command: #{options['shell']} #{options['args']} -c \"#{cmd}\""
            `#{options['shell']} #{options['args']} -c "#{cmd}"`
            $?.exitstatus
          else
            1
          end
        when 'system'
          if options['command_string']
            cmd = MDT::Helpers::Command.apply_command_modifiers(options['command_string'], modifiers)
            puts "Running command: #{cmd}"
            `#{cmd}`
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
              FileUtils.cd(options['path'])
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
                FileUtils.cp_r(options['source_path'], options['destination_path'])
              else
                puts "Copying from: #{options['source_path']} to: #{options['destination_path']}"
                FileUtils.cp(options['source_path'], options['destination_path'])
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
              FileUtils.mv(options['source_path'], options['destination_path'])
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
                FileUtils.rm_rf(options['path'])
              elsif options['recursive']
                puts "Removing recursively: #{options['path']}"
                FileUtils.rm_r(options['path'])
              elsif options['force']
                puts "Removing with force: #{options['path']}"
                FileUtils.rm_f(options['path'])
              else
                puts "Removing: #{options['path']}"
                FileUtils.rm(options['path'])
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
               FileUtils.ln_sf(options['destination_path'], options['link_name'])
             elsif options['symbolic']
               puts "Creating a symbolic link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_s(options['destination_path'], options['link_name'])
             elsif options['force']
               puts "Creating a link with force to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_f(options['destination_path'], options['link_name'])
             else
               puts "Creating a link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln(options['destination_path'], options['link_name'])
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
                FileUtils.chmod_R(options['mode'], options['destination_path'])
              else
                puts "Changing mode to: #{options['mode']} of: #{options['destination_path']}"
                FileUtils.chmod(options['mode'], options['destination_path'])
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
                FileUtils.chown_R(options['user'], options['group'], options['destination_path'])
              else
                puts "Changing owner to: #{options['user']}:#{options['group']} of: #{options['destination_path']}"
                FileUtils.chown(options['user'], options['group'], options['destination_path'])
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
              FileUtils.touch(options['path'])
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