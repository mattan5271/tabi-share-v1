class CreateTouristSpotImages < ActiveRecord::Migration[5.2]
  def change
    create_table :tourist_spot_images do |t|
      t.integer :tourist_spot_id, null: false
      t.string :image_id
      t.timestamps
    end
  end
end
