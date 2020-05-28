class AddHomePageToTouristSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :tourist_spots, :home_page, :string
    change_column :tourist_spots, :home_page, :string, null: false
  end
end
