class Scene < ApplicationRecord
  has_many :tourist_spot_scenes
  has_many :tourist_spots, through: :tourist_spot_scenes

  attachment :image

  validates :name, presence: true, length: { maximum: 20 }
end
