class AddLocalIndicator < ActiveRecord::Migration
  def self.up
    add_column :teams, :local, :boolean, :default => false
  end

  def self.down
    remove_column :teams, :local
  end
end
