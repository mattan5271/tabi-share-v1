class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tourist_spot

  has_many :review_images, dependent: :destroy
  has_many :review_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
