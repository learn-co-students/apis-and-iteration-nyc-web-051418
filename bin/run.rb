#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../lib/movie_search.rb"

welcome
choice = get_choice

if choice == "1"
  episode_number = get_movie_from_user
  show_episode_details(episode_number)
else
  character = get_character_from_user
  show_character_movies(character)
end
