def welcome
  # puts out a welcome message here!
  puts "Welcome to our program!"
end

def get_character_from_user
  puts "Please enter a Star Wars character"
  # use gets to capture the user's input. This method should return that input, downcased.
  userInput = gets.chomp
  userInput.downcase
end
