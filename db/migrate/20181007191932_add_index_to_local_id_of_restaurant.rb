class AddIndexToLocalIdOfRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_index :restaurants, :local_id
    add_index :restaurants, :local_id, unique: true
  end
end
