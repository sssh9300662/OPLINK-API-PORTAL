class CreateErrorResponses < ActiveRecord::Migration
  def change
    create_table :error_responses do |t|
      t.integer :api_id
      t.integer :code
      t.string :reason
      t.timestamps
    end
    add_index :error_responses, [:api_id]
    add_index :error_responses, [:api_id, :code]
  end
end
