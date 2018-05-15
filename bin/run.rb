#!/usr/bin/env ruby
require 'pry'
require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
search_value = get_character_from_user
selector(search_value)
