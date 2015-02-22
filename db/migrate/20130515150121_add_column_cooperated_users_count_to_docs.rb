class AddColumnCooperatedUsersCountToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :cooperated_users_count, :integer, :default => 0, :after => :subdomain
  end
end
