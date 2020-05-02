class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tourist_spot

  has_many :review_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum is_value: { "本名": true, "ニックネーム": false }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
