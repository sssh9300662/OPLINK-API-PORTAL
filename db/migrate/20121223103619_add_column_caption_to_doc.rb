class AddColumnCaptionToDoc < ActiveRecord::Migration
  def change
    add_column :docs, :caption, :string, :after => :name
  end
end
