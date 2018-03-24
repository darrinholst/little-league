class AddLocalToField < ActiveRecord::Migration
  def change
    add_column :fields, :local, :boolean, :default => false
  end
end
