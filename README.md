# MDT - Simple module

A module with simple implementations for MDT.

## Requirements

* [mdt-core](https://github.com/Phitherek/mdt-core "mdt-core") >= 0.0.1
* Ruby (tested with 2.5.0, earlier versions down to 2.0 may also work)
* RubyGems

## Installation

`gem install mdt-dummy`

## Usage

The module is automatically loaded by `mdt`. All you need to do is to use appropriate keys in your `mdt-deploy.yml`.

## Objects defined by module

### Command modifiers

* `simple.env` - prepends an environment variable to the command.
Options:
    * `name` - name of the variable
    * `value` - value of the variable
* `simple.sudo` - prepends sudo to the command.
Options:
    * `args` - arguments with options for sudo (optional)
* `simple.generic` - prepends given string to the command.
Options:
    * `modifier_str` - string to prepend to the command
### Commands

* `simple.shell` - runs a command in a shell applying the command modifiers. Options:
    * `shell` - the shell executable (optional, default: `/bin/bash`)
    * `args` - arguments with options for the shell (optional)
    * `command` - command to execute in the shell
* `simple.system` - runs a command applying the command modifiers. Options:
    * `command_string` - command to execute
* `simple.mkdir` - creates a directory. Options:
    * `path` - a path of a directory to be created
    * `parents` - truthy if non-exising parents of the directory should be created too, falsey otherwise (empty also means falsey)
* `simple.cd` - changes the working directory. Options:
    * `path` - a path of the new working directory
* `simple.cp` - copies files and directories from source to destination. Options:
    * `source_path` - a path specifying the elements to be copied
    * `destination_path` - a path specifying where the elements should be copied
    * `recursive` - truthy if directories should be copied recursively, falsey otherwise (empty also means falsey)
* `simple.mv` - moves files and directories from source to destination. Options:
    * `source_path` - a path specifying the elements to be moved
    * `destination_path` - a path specifying where the elements should be moved
* `simple.rm` - removes files and directories. Options:
    * `path` - a path specifying the elements to be removed
    * `recursive` - truthy if directories should be removed recursively, falsey otherwise (empty also means falsey)
    * `force` - truthy if the removal should be forced, falsey otherwise (empty also means falsey)
* `simple.ln` - creates links. Options:
    * `destination_path` - a path specifying what should be the destination of the link
    * `link_name` - a path being the name of the link
    * `symbolic` - truthy if the link should be symbolic, falsey otherwise (empty also means falsey)
    * `force` - truthy if creation of the link should be forced, falsey otherwise (empty also means falsey)
* `simple.chmod` - changes mode of files and directories. Options:
    * `mode` - a mode to set
    * `destination_path` - a path specifying where the mode should be changed
    * `recursive` - truthy if the mode should be changed recursively, falsey otherwise (empty also means falsey)
* `simple.chown` - changes owner of files and directories. Options:
    * `user` - the user which should be the owner
    * `group` - the group which should be the owner
    * `destination_path` - a path specifying where the owner should be changed
    * `recursive` - truthy if the owner should be changed recursively, falsey otherwise (empty also means falsey)
* `simple.touch` - creates a file or updates its modification date. Options:
    * `path` - a path specifying the file that should be touched

### Directory choosers

* `simple.directory` - uses a simple directory path. Creates and changes to the directory. Does not remove the directory on failure. Options:
    * `path` - a path to the deploy directory
    
### Fetchers

* `simple.directory` - uses a local directory. Options:
    * `path` - a path to the source directory

## Contributing

You can contribute to the development of this MDT module by submitting an issue or pull request.

## Documentation

Generated RDoc documentation can be found [here](https://rubydoc.info/github/Phitherek/mdt-simple "here").