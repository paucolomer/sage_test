require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
	test "valid character" do
		ch = Character.new(name: 'Pau', status: Character::STATUS_ALIVE, 
			image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg')
		assert ch.valid?, 'Character must have name, status and image'
	end

	test "wrong status value" do
		ch = Character.new(name: 'Pau', status: 5, 
			image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg')
		refute ch.valid?, 'Character passed with wrong status value'
	end

	test "without name" do
		ch = Character.new(status: Character::STATUS_ALIVE,
			image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg')
		refute ch.valid?, 'Character passed without name'
	end

	test "without image" do
		ch = Character.new(name: 'Pau', status: Character::STATUS_ALIVE)
		refute ch.valid?, 'Character passed without image'
	end
end
