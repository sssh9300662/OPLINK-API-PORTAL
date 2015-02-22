class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.integer :operation_id
      t.string :param_type
      t.string :name
      t.string :description
      t.string :data_type
      t.boolean :required
      t.text :allowable_values
      t.boolean :allow_multiple
      t.timestamps
    end
    add_index :parameters, [:operation_id]
  end
end
