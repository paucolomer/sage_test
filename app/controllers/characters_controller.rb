class CharactersController < ApplicationController

	def index
		@pagy, @characters = pagy(Character)
	end

end
