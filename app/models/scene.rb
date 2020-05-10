class Scene < ApplicationRecord
  has_many :tourist_spots, dependent: :destroy

  attachment :image

  validates :name, presence: true, length: { maximum: 20 }
end
