class CreateTouristSpotLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :tourist_spot_likes do |t|
      t.integer :user_id, null: false
      t.integer :tourist_spot_id, null: false
      t.timestamps
    end
  end
end
