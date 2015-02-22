class RemoveUslessColumnAndTable < ActiveRecord::Migration
  def up
    remove_column :apis, :nickname
    drop_table :operations
  end

  def down
  end
end
