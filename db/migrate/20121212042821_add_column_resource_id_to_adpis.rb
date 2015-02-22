class AddColumnResourceIdToAdpis < ActiveRecord::Migration
  def change
    add_column :apis, :resource_id, :integer, :after => :doc_id
    remove_column :apis, :doc_id
    add_index :apis, :resource_id
    add_column :apis, :http_method, :string, :after => :description
    add_column :apis, :nickname, :string, :after => :http_method
    add_column :apis, :response_class, :string, :after => :nickname
    add_column :apis, :summary, :string, :after => :response_class
    add_column :apis, :note, :string, :after => :summary
    remove_column :apis, :description
    add_column :parameters, :api_id, :integer, :after => :operation_id
    remove_column :parameters, :operation_id
    add_index :parameters, :api_id
    add_column :resources, :description, :string, :after => :name
  end
end
