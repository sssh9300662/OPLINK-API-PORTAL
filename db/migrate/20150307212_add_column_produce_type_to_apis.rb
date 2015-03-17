class AddColumnProduceTypeToApis < ActiveRecord::Migration
  def change
    add_column :apis, :produce_type, :string, :after => :consume_type
  end
end
