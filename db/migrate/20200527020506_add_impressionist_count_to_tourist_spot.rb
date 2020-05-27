class AddImpressionistCountToTouristSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :tourist_spots, :impressionist_count, :integer
  end
end
