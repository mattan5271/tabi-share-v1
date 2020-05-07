class AddImageIdToScenes < ActiveRecord::Migration[5.2]
  def change
    add_column :scenes, :image_id, :string
  end
end
