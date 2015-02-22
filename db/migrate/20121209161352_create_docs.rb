class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :api_version
      t.string :base_path
      t.timestamps
    end
    add_index :docs, :name
    add_index :docs, :user_id
  end
end
