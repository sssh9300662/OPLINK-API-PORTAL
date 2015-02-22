class AddColumnDocIdToApis < ActiveRecord::Migration
  def change
    add_column :apis, :doc_id, :integer, :after => :resource_id
    add_index :apis, [:path, :doc_id, :http_method]
    add_index :apis, :doc_id
    Api.scoped.includes(:resource).find_each do |api|
      api.update_column :doc_id, api.resource.doc_id if api.resource
    end
  end
end
