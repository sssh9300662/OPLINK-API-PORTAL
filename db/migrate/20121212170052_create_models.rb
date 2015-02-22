class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.string :description
      t.integer :doc_id
      t.timestamps
    end
    add_index :models, [:doc_id, :name]
    add_index :models, :doc_id
  end
end
