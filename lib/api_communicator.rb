require 'rest-client'
require 'json'
require 'pry'


def find_character(page_num, character)
  all_characters = RestClient.get("http://www.swapi.co/api/people/?page=1")
  character_hash = JSON.parse(all_characters)

  char_hash = {}
  while character_hash["next"] != nil
    #make the web request on input page
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{page_num}")
    character_hash = JSON.parse(all_characters)
    character_info = character_hash["results"]

    #check to see if name matches
    character_info.each do |info|
      if info["name"].downcase == character
        char_hash = info
        return char_hash
      end
    end
    page_num += 1
  end
  puts "Invalid input."
  abort()
end


def get_character_movies_from_api(character)
  page_num = 1
  char_hash = find_character(page_num, character)

  movie_array = char_hash["films"]
  movie_info = []
  movie_array.each do |link|
  movie_link = RestClient.get(link)
  movie_info_hash = JSON.parse(movie_link)
  movie_info << movie_info_hash
  end
  return movie_info
end

def convert_list_of_API(api_list)
  api_list.each_with_index do |link, dex|
    movie_link = RestClient.get(link)
    movie_info_hash = JSON.parse(movie_link)
    if dex != api_list.length-1
      print "#{movie_info_hash["name"]}, "
    else
      print "#{movie_info_hash["name"]}"
    end
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |info|
    info.each do |data|
      if data[1].class == Array
        print "#{data[0]}: "
        #something
        convert_list_of_API(data[1])
        puts " "
      else
        puts "#{data[0]}: #{data[1]}"
      end
    end
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
