class AddHeightAndWidthAndFormatToBit < ActiveRecord::Migration
  def change
    add_column :bits, :height, :integer
    add_column :bits, :width, :integer
    add_column :bits, :format, :string
  end
end
