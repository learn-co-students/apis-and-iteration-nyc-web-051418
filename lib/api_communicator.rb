# require 'rest-client'
# require 'json'
# require 'pry'
#
# def get_character_movies_from_api(character)
#   #make the web request
#   all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#
#   # iterate over the character hash to find the collection of `films` for the given
#   #   `character`
#   # collect those film API urls, make a web request to each URL to get the info
#   #  for that film
#   # return value of this method should be collection of info about each film.
#   #  i.e. an array of hashes in which each hash reps a given film
#   # this collection will be the argument given to `parse_character_movies`
#   #  and that method will do some nice presentation stuff: puts out a list
#   #  of movies by title. play around with puts out other info about a given film.
# end
#
# def parse_character_movies(films_hash)
#   # some iteration magic and puts out the movies in a nice list
# end
#
# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end
#
# ## BONUS
#
# # that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# # can you split it up into helper methods?











require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
# character_hash["results"].map{|film| film["films"]}
#   }
#film=nil
#character_hash["results"].each do |info,data|
#  if character_hash["results"][info]["name"].include?(character)
#    film=character_hash["results"][info]["films"]
#  end
#end
film=character_hash["results"].select do |info|
  info["name"].downcase==character
end
film=film[0]["films"]

parse_character_movies(film)


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


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
all_movie_title=[]
all_movie_descr=[]
  films_hash.map do |urls|
    movie = RestClient.get(urls)
    json = JSON.parse(movie)
    all_movie_title << json["title"]
    all_movie_descr << json["opening_crawl"]
  end

  # films_hash.map do |urls|
  #   movie = RestClient.get(urls)
  #   json = JSON.parse(movie)
  #   all_movie_descr << json["opening_crawl"]

  #end
  movie_hash={}
  all_movie_title.zip(all_movie_descr) do |key,value|
    movie_hash[key.to_sym]=value
  end
  movie_hash.each do |key,value|
    puts "\n Title: #{key.to_s} \n Desciption: #{value.to_s} \n"

    #puts "Desciption: #{value.to_s} \n"
  end
#binding.pry
  #all_movie

end

# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
