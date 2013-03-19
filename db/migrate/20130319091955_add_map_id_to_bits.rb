class AddMapIdToBits < ActiveRecord::Migration
  def change
    add_column :bits, :map_id, :integer
  end
end
