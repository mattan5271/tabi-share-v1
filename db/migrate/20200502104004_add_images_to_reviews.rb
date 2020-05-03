class AddImagesToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :images, :json
  end
end
