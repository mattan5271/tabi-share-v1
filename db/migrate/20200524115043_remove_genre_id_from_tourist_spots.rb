class RemoveGenreIdFromTouristSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :tourist_spots, :genre_id, :integer
  end
end
