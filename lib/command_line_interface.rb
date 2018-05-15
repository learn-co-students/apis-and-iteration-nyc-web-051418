require "rest-client"
require "pry"
require "json"

def welcome
  puts "welcome!"
end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  character.downcase
end
