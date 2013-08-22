class DropClustersTable < ActiveRecord::Migration
  def up
  	drop_table :clusters
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
