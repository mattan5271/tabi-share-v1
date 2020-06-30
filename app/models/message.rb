class Message < ApplicationRecord
  include Paginate

  belongs_to :user
  belongs_to :room

  has_many :notifications, dependent: :destroy

  validates :body, presence: true
end
