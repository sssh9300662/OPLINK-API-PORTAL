class AddColumnProduceTypeToProperties < ActiveRecord::Migration
  def change
    t.boolean  "required"
    t.text     "allowable_values"
    t.boolean  "allow_multiple"
    add_column :parameters, :required, :boolean, :after => :description
  end
end
