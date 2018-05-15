require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

  all_characters = RestClient.get("http://www.swapi.co/api/people/?page=1")
  character_hash = JSON.parse(all_characters)

  the_character = ""

  index = 1
  while character_hash["next"] != nil
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{index}")
    character_hash = JSON.parse(all_characters)

    characters = character_hash["results"]

    characters.each do |char|
      if char["name"].downcase == character || char["name"] == character
        the_character = char
        break
      end
    end



    index +=1
  end

  if the_character == ""
    puts "Character doesn't exist"
  end



  # all_characters = RestClient.get('http://www.swapi.co/api/people/#{}')
  # character_hash = JSON.parse(all_characters)
  # binding.pry



  # iterate over the character hash to find the collection of `films` for the given
  #   `character`




  films = the_character["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


  films.map do |film|
    film_name = RestClient.get(film)
    films_hash = JSON.parse(film_name)
  end
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  titles = []
  films_hash.map do |film|
    titles << film["title"]
  end
  puts "------------"
  puts titles
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def get_movie_info_from_api(movie)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  characters = character_hash["results"]
  films = characters.map do |char|
    char["films"]
  end

  films.flatten!.uniq!

  movies = films.map do |film|
    film_name = RestClient.get(film)
    films_hash = JSON.parse(film_name)
  end

  movies.find do |film|
    film["title"] == movie
  end
end

def parse_movie(movie_hash)
  puts "-------------"
  puts "#{movie_hash["title"]} was produced by: #{movie_hash["producer"]}"
  puts "#{movie_hash["title"]} was directed by: #{movie_hash["director"]}"
  puts "#{movie_hash["title"]} was released on: #{movie_hash["release_date"]}"
end

def show_movie_details(movie)
  movie_hash = get_movie_info_from_api(movie)
  parse_movie(movie_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
