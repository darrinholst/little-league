class AddMorePlayerAttributes < ActiveRecord::Migration
  def self.up
    add_column :players, :birthdate, :date
    add_column :players, :parents, :string
    add_column :players, :phone_number, :string
    add_column :players, :alternate_phone_number, :string
    add_column :players, :shirt_size, :string
  end

  def self.down
  end
end
