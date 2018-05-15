require 'rest-client'
require 'json'
require 'pry'


def get_all_pages
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

    array = []
    count = character_hash["count"].round(-1)
    pages = (count/10)

    ctr = 1
        while ctr <= pages
          i = RestClient.get("http://www.swapi.co/api/people/?page=#{ctr}")
          b = JSON.parse(i)
          c = b["results"]
          array << c

          ctr +=1
        end
        array.flatten
end

def get_character_movies_from_api(character)
  character_hash = get_all_pages
  character_info = character_hash.select do |characters|
    characters["name"].downcase ==  character.downcase
  end

  if character_info == []
    abort()
  end

  films = character_info[0]["films"]

  films.map do |film|
    film_info = RestClient.get("#{film}")
    film_p = JSON.parse(film_info)
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts "Title: #{film["title"]}"
    puts "Director: #{film["director"]}"
    puts "Release: #{film["release_date"]}"
    puts "Crawl: #{film["opening_crawl"][0..150]}"
    puts "\n"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
