class FixClusterId < ActiveRecord::Migration
  def up
  	rename_column :parallels, :cluster_id, :map_id
  end

  def down
  	rename_column :parallels, :map_id, :cluster_id
  end
end
