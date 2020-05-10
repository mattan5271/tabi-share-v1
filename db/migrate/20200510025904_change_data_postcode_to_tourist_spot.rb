class ChangeDataPostcodeToTouristSpot < ActiveRecord::Migration[5.2]
  def change
    change_column :tourist_spots, :postcode, :string
  end
end
