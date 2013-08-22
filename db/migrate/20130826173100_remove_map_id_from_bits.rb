class RemoveMapIdFromBits < ActiveRecord::Migration
  def up
    remove_column :bits, :map_id
  end

  def down
    add_column :bits, :map_id, :integer
  end
end
