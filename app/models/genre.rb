class Genre < ApplicationRecord
  has_many :tourist_spots, dependent: :destroy
end
