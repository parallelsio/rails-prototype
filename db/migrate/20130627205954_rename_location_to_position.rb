class RenameLocationToPosition < ActiveRecord::Migration
  def self.up
  	rename_column :bits, :location_y, :position_y
  	rename_column :bits, :location_x, :position_x
  	rename_column :clusters, :location_y, :position_y
  	rename_column :clusters, :location_x, :position_x

  end

  def down
  	rename_column :bits, :position_y, :location_y
  	rename_column :bits, :position_x, :location_x
  	rename_column :clusters, :position_y, :location_y
  	rename_column :clusters, :position_x, :location_x
  end
end


