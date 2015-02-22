class AddColumnApiKeyNameToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :api_key_name, :string, :after => :api_key, :default => :api_key
  end
end
