class AddOrderAndColorToDivisions < ActiveRecord::Migration
  def self.up
    add_column :divisions, :sort_order, :integer
    add_column :divisions, :color, :string
  end

  def self.down
  end
end
