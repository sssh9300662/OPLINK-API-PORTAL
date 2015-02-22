class AddApiTestingColumnsToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :request_path, :string, :after => :base_path
    add_column :docs, :api_key, :string, :after => :request_path
  end
end
