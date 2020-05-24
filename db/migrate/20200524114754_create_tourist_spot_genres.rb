class CreateTouristSpotGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :tourist_spot_genres do |t|
      t.integer :tourist_spot_id, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end
  end
end
