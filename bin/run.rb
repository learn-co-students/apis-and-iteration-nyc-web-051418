#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome

begin

  character = get_character_from_user
  show_character_movies(character)

rescue
  puts "That is not a valid Star Wars character you dummy!"
  puts "\n"
end
