require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  new_character_array = []
  character_hash["results"].each do |character_array|
    if character_array["name"].downcase == character
       new_character_array << character_array["films"]
    end
  end
    film_url_array = new_character_array.flatten
    url_array(film_url_array)

end

def parse_character_movies(films_hash, character)
    # some iteration magic and puts out the movies in a nice list
  counter = 1
  #input_name = get_character_from_user
  puts "#{character} has been in the following episodes"
  films_hash.map do |film|
  puts  "#{counter}: #{film["title"]}."
  counter += 1
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash, character)
end


## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
def url_array(url)
film_info_array = []
  url.map do |film_url|
    titles_api = RestClient.get(film_url)
    titles_json = JSON.parse(titles_api)
    film_info_array << titles_json
  end
film_info_array
end
