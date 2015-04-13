class AlertColumnNoteToApis < ActiveRecord::Migration
  def change
    change_column :apis, :note, :text
  end
end
