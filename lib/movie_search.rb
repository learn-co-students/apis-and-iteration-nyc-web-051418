require 'rest-client'
require 'json'
require 'pry'



def get_episode_from_api(episode_number)
  #make the web request
  all_episodes = RestClient.get('https://swapi.co/api/films/')
  # parse json to hash
  episode_hash = JSON.parse(all_episodes)
  # obtain a hash for our episode_number
  episode_info = get_episode(episode_hash, episode_number)
  puts "Title: #{episode_info["title"]}, Director: #{episode_info["director"]}, Producer: #{episode_info["producer"]}, Release Date: #{episode_info["release_date"]}"
end


def get_episode(episode_hash, episode_number)
  episode_hash["results"].each do |items|
    if items["episode_id"] == episode_number.to_i
      return items
    end
  end
end


def show_episode_details(episode_number)
  get_episode_from_api(episode_number)
end
