class CreateDocUsers < ActiveRecord::Migration
  def change
    create_table :doc_users do |t|
      t.integer :doc_id
      t.integer :user_id
      t.timestamps
    end
    add_index :doc_users, :doc_id
    add_index :doc_users, :user_id
    add_index :doc_users, [:doc_id, :user_id]
  end
end
