class AddColumnRequiredMultipleToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :required, :boolean, :after => :description
    add_column :properties, :allow_multiple, :boolean, :after => :required
  end
end
