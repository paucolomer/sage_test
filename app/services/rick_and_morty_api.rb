require 'net/http'
require 'ostruct'

class RickAndMortyApi
	URL="https://rickandmortyapi.com/api/character".freeze

	def self.import_characters(opts={})
		
		# Delete all characters and episodes from the DB in an efficient way
		CharactersEpisodes.delete_all
		Character.delete_all
		Episode.delete_all

		n_pages = 1
		episodes = []
		res = get(URL)
		handle_result(res, episodes)
		while !res["info"]["next"].nil?
			Rails.logger.info("Imported page #{n_pages}")
			res = get(res["info"]["next"])
			handle_result(res, episodes)
			n_pages += 1
		end
		Rails.logger.info("Imported #{Character.count} characters and #{episodes.size} episodes")
	end

protected
	def self.get(url)
		# Performs GET call of the given url and returns the JSON object
		# It raises an exception of type Exceptions::RickAndMortyApiError
		# when the HTTP response is not ok
		response = ::Net::HTTP.get_response(URI.parse(url))
		unless response.is_a?(Net::HTTPSuccess)
			raise Exceptions::RickAndMortyApiError.new(
				I18n.t('services.rick_and_morty_api.errors.wrong_http'))
		end
		JSON.parse(response.body)
	end

	def self.handle_result(res, episodes)
		# Handle result of a response
		# episodes is an array used to store episodes already created in the DB
		(res['results'] || []).each do |character|

			# Ensure all episodes exist in the db
			current_episodes = []
			(character['episode'] || []).each do |episode_url|
				id_episode = episode_url.split("/")[-1].to_i
				current_episodes << id_episode
				unless episodes.include?(id_episode)
					Episode.create!(id: id_episode)
					episodes << id_episode
				end
			end

			# Get the character from the db
			ch = Character.where(id: character['id']).first

			# Get data to be stored
			ch_data = {name: character['name'], 
					status: Character.status_from_str(character['status']),
					image: character['image']}

			# Create or update the current character
			if ch.nil?
				ch = Character.create!(ch_data)
			else
				ch.update!(ch_data)
			end

			# Update the episodes of the current character
			ch.episode_ids = current_episodes
		end
	end
end