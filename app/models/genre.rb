class Genre < ApplicationRecord
  has_ancestry
  has_many :tourist_spot_genres
  has_many :tourist_spots, through: :tourist_spot_genres

  attachment :image

  validates :name, presence: true, length: { maximum: 20 }

end
