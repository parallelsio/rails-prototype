class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.integer :location_x
      t.integer :location_y

      t.timestamps
    end
  end
end
