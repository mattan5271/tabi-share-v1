class RemoveSceneIdFromTouristSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :tourist_spots, :scene_id, :integer
  end
end
