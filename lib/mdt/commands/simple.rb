require 'mdt-core'
require 'fileutils'
require 'open3'
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
            (cmd_stdout, cmd_stderr, status) = Open3.popen3("#{options['shell']} #{options['args']} -c \"#{cmd}\"") do |stdin, stdout, stderr, wait_thr|
              exit_status = wait_thr.value
              cmd_stdout = stdout.read
              cmd_stderr = stderr.read
              [cmd_stdout, cmd_stderr, exit_status]
            end
            puts
            puts 'STDOUT:'
            puts cmd_stdout
            puts
            puts 'STDERR:'
            puts cmd_stderr
            puts
            status.exitstatus
          else
            1
          end
        when 'system'
          if options['command_string']
            cmd = MDT::Helpers::Command.apply_command_modifiers(options['command_string'], modifiers)
            puts "Running command: #{cmd}"
            (cmd_stdout, cmd_stderr, status) = Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
              exit_status = wait_thr.value
              cmd_stdout = stdout.read
              cmd_stderr = stderr.read
              [cmd_stdout, cmd_stderr, exit_status]
            end
            puts
            puts 'STDOUT:'
            puts cmd_stdout
            puts
            puts 'STDERR:'
            puts cmd_stderr
            puts
            status.exitstatus
          else
            1
          end
        when 'mkdir'
          if options['path']
            begin
              if options['parents']
                puts "Creating directory with parents: #{options['path']}"
                FileUtils.mkdir_p(Dir[options['path']].first)
              else
                puts "Creating directory: #{options['path']}"
                FileUtils.mkdir(Dir[options['path']].first)
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
               FileUtils.ln_sf(Dir[options['destination_path']].first, Dir[options['link_name']].first)
             elsif options['symbolic']
               puts "Creating a symbolic link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_s(Dir[options['destination_path']].first, Dir[options['link_name']].first)
             elsif options['force']
               puts "Creating a link with force to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln_f(Dir[options['destination_path']].first, Dir[options['link_name']].first)
             else
               puts "Creating a link to: #{options['destination_path']} named: #{options['link_name']}"
               FileUtils.ln(Dir[options['destination_path']].first, Dir[options['link_name']].first)
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