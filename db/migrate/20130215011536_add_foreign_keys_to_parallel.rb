class AddForeignKeysToParallel < ActiveRecord::Migration
  def change
    add_column :parallels, :bit_id, :integer
    add_column :parallels, :cluster_id, :integer
  end
end
