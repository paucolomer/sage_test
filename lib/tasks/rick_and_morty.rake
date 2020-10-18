namespace :rick_and_morty do
	desc "Import characters from Rick and Morty API"
	task :import => :environment do
		ActiveRecord::Base.logger = nil # No sql logs
    Rails.logger.extend(ActiveSupport::Logger.broadcast(ActiveSupport::Logger.new(STDOUT)))

		Rails.logger.info("Importing characters ...")
		begin
			RickAndMortyApi.import_characters
		rescue StandardError => ex
			Rails.logger.error("Something went wrong importing characters: #{ex.message}\n#{ex.backtrace.join("\n")}")
		end
		Rails.logger.info("Characters imported")
	end
end