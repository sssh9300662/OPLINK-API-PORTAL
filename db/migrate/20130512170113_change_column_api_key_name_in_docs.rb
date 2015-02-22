class ChangeColumnApiKeyNameInDocs < ActiveRecord::Migration
  def up
    change_column :docs, :api_key_name, :string, :default => "token"
  end

  def down
  end
end
