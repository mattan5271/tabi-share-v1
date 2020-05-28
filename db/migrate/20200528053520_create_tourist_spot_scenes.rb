class CreateTouristSpotScenes < ActiveRecord::Migration[5.2]
  def change
    create_table :tourist_spot_scenes do |t|
      t.integer :tourist_spot_id, null: false
      t.integer :scene_id, null: false
      t.timestamps
    end
  end
end
