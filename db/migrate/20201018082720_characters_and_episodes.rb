class CharactersAndEpisodes < ActiveRecord::Migration[5.2]
  def change
  	create_table :characters do |t|
  		t.string :name
  		t.integer :status
  		t.string :image
  		t.timestamps
  	end

  	create_table :episodes do |t|
  		t.timestamps
  	end

    create_join_table :characters, :episodes do |t|
      t.index [:character_id, :episode_id]
    end
  end
end
