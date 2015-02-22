class RemoveColumnBasePathInDocs < ActiveRecord::Migration
  def up
    Doc.find_each do |doc|
      doc.update_column :request_path, doc.base_path unless doc.request_path.present?
    end
    remove_column :docs, :base_path
  end

  def down
  end
end
