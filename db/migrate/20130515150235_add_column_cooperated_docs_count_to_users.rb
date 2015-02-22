class AddColumnCooperatedDocsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cooperated_docs_count, :integer, :default => 0, :after => :facebook_id
  end
end
