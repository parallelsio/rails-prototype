class CreateBits < ActiveRecord::Migration
  def change
    create_table :bits do |t|
      t.text :content
      t.string :color
      t.string :type
      t.integer :location_x
      t.integer :location_y
      t.string :image

      t.timestamps
    end
  end
end
