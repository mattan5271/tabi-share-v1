class TouristSpotImage < ApplicationRecord
  belongs_to :tourist_spot
  attachment :image
end
