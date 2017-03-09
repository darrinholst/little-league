class AddAddresses < ActiveRecord::Migration
  def change
    add_column :players, :address, :string
    add_column :players, :city, :string, :default => 'Perry'
    add_column :players, :state, :string, :default => 'IA'
    add_column :players, :zip, :string, :default => '50220'
    add_column :coaches, :address, :string
    add_column :coaches, :city, :string, :default => 'Perry'
    add_column :coaches, :state, :string, :default => 'IA'
    add_column :coaches, :zip, :string, :default => '50220'
  end
end
