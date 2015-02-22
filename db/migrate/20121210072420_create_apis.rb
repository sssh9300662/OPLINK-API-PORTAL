class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.integer :doc_id
      t.string :path
      t.string :description
      t.timestamps
    end
    add_index :apis, [:doc_id]
  end
end
