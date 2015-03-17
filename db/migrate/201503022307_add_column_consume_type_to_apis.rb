class AddColumnConsumeTypeToApis < ActiveRecord::Migration
  def change
    add_column :apis, :consume_type, :string, :after => :response_class
  end
end
