class ChangeLatLngColumnsOfRestaurant < ActiveRecord::Migration[5.2]
  def up
    change_column_null :restaurants, :lat, false
    change_column_null :restaurants, :lng, false
  end

  def down
    change_column_null :restaurants, :lat, true
    change_column_null :restaurants, :lng, true
  end
end
