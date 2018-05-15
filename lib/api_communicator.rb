require 'rest-client'
require 'json'
require 'pry'

#method parses json from api arguement
def parse_json(api)
  specific_movie = RestClient.get(api)
  movie_detail_hash = JSON.parse(specific_movie)
end

def get_character_movies_from_api(character, api)
  character_hash = parse_json(api)
  result = []
  character_hash["results"].each do |character_data|
      if character_data["name"].downcase == character
          movies_array = character_data["films"]
          movies_array.each {|film_details| result <<  parse_json(film_details)}
          return result
      end
  end
  get_character_movies_from_api(character, character_hash["next"])
  #change API url if result is empty
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.map {|film| puts film["title"]}
end

def show_character_movies(character)
  #find character in API - return API URL
  films_hash = get_character_movies_from_api(character, 'http://www.swapi.co/api/people/')
  parse_character_movies(films_hash)
end












  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


  ## BONUS

  # that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
  # can you split it up into helper methods?
