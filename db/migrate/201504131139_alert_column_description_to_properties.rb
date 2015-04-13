class AlertColumnDescriptionToProperties < ActiveRecord::Migration
  def change
    change_column :properties, :description, :string, :limit=>1024
  end
end
