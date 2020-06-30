class Comment < ApplicationRecord
  include Paginate

  belongs_to :user
  belongs_to :review

  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 100 }
end
