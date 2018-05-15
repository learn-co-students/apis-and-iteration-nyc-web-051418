require 'pry'

def welcome
  puts "Welcome to this Star Wars app!"
end

def get_character_from_user
  puts "please choose people, planets, films, species, vehicles, or starships"
  search_type = gets.chomp.downcase

  puts "please enter a name"
  name = gets.chomp.downcase
  #"luke skywalker"
  # use gets to capture the user's input. This method should return that input, downcased.
 {  "search_type" => search_type, "name" => name  }


end
