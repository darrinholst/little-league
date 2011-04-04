class SeedFields < ActiveRecord::Migration
  def self.up
    Field.create!(:name => "Rookie")
    Field.create!(:name => "Minor")
    Field.create!(:name => "Major")
  end

  def self.down
  end
end
