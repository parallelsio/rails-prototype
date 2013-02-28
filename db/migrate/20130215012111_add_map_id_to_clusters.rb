class AddMapIdToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :map_id, :integer
  end
end
