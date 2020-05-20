class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
