class AddColumnSortToApis < ActiveRecord::Migration
  def change
    add_column :apis, :sort, :integer, :after => :note
    add_index :apis, [:sort, :doc_id]
    change_column :resources, :sort, :integer
    add_index :resources, [:sort, :doc_id]
  end
end
