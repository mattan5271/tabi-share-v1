class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 200 }
end
