class AddLonLatToRestaurant < ActiveRecord::Migration[5.2]
  def up
    add_column :restaurants, :lonlat, :st_point, geographic: true
  end
end
