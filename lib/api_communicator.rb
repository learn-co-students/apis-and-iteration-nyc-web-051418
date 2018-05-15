require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  page = 1
  all_characters = RestClient.get('http://www.swapi.co/api/people/?page=#{page}&format=json')
  character_hash = JSON.parse(all_characters)

end


def get_character_info_from_hash(character, character_hash)

    results        = character_hash["results"]

    character_info = results.select do |characters|
    characters["name"].downcase ==  character.downcase
  end
end


def get_character_movies(character_info)

  films = character_info[0]["films"]

    films.map do |film|
    film_info = RestClient.get("#{film}")
    film_p    = JSON.parse(film_info)
  end
end


def parse_character_movies(films_hash)

  films_hash.map do |film|
    puts "Title: #{film["title"]}"
    puts "Director: #{film["director"]}"
    puts "Release: #{film["release_date"]}"
    puts "Crawl: #{film["opening_crawl"][0..140]}"
    puts "\n"
    puts "==================================================="
    puts "\n"
  end
end


def show_character_movies(character)

  char_hash  = get_character_movies_from_api(character)
  char_info  = get_character_info_from_hash(character, char_hash)
  films_hash = get_character_movies(char_info)

  parse_character_movies(films_hash)
end
