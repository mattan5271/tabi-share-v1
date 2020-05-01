class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :tourist_spot_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :score, null: false
      t.boolean :is_value, default: true, null: false
      t.timestamps
    end
  end
end
