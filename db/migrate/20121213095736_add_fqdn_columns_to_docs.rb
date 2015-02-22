class AddFqdnColumnsToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :fqdn, :string, :after => :base_path
    add_column :docs, :subdomain, :string, :after => :fqdn
    add_index :docs, [:fqdn]
    add_index :docs, [:subdomain]
  end
end
