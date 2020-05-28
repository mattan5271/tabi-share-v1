class AddIsParkingToTouristSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :tourist_spots, :parking, :text
    change_column :tourist_spots, :parking, :text, :null => false
  end
end
