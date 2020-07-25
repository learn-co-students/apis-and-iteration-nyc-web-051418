def welcome
  puts "Welcome!"
  get_character_from_user
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp.downcase
  show_character_movies(character)
end
