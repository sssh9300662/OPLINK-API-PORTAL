class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :model_id
      t.string :name
      t.string :data_type
      t.string :description
      t.string :allowable_values
      t.timestamps
    end
    add_index :properties, [:model_id]
    add_index :properties, [:model_id, :name]
  end
end
