class CreateParallels < ActiveRecord::Migration
  def change
    create_table :parallels do |t|

      t.timestamps
    end
  end
end
