require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  films_array = character_hash["results"].find do |character_data|
    character_data["name"].downcase == character
  end

  films = films_array["films"]

  get_film_array_from_api(films)

end

def get_film_array_from_api(films)
  films.map do |film_hash|
    all_film_data = RestClient.get(film_hash)
    JSON.parse(all_film_data)
  end
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |movie_data_package|
    puts movie_data_package["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  #binding.pry
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
