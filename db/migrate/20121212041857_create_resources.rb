class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :doc_id
      t.string :name
      t.integer :sort, :default => 999
      t.timestamps
    end
    add_index :resources, :doc_id
  end
end
