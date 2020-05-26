class AddIsParkingToTouristSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :tourist_spots, :is_parking, :text
    change_column :tourist_spots, :is_parking, :text, :null => false
  end
end
