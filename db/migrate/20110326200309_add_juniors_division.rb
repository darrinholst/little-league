class AddJuniorsDivision < ActiveRecord::Migration
  def self.up
    Division.create!(:name => "Juniors")
  end

  def self.down
  end
end
