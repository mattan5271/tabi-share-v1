class ChangeDataPostcodeToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :postcode, :string
  end
end
