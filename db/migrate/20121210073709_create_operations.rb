class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :api_id
      t.string :http_method
      t.string :nickname
      t.string :response_class
      t.string :summary
      t.string :note
      t.timestamps
    end
    add_index :operations, [:api_id]
  end
end
