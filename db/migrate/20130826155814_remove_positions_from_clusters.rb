class RemovePositionsFromClusters < ActiveRecord::Migration
  def up
    remove_column :clusters, :position_x
    remove_column :clusters, :position_y
  end

  def down
    add_column :clusters, :position_y, :string
    add_column :clusters, :position_x, :string
  end
end
