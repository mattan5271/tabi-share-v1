class Entry < ApplicationRecord
  include Paginate

  belongs_to :user
  belongs_to :room
end
