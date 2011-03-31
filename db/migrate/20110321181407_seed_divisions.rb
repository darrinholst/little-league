class SeedDivisions < ActiveRecord::Migration
  def self.up
    Division.create!(:name => "T-Ball")
    Division.create!(:name => "Rookies")
    Division.create!(:name => "Minors")
    Division.create!(:name => "Majors")
  end

  def self.down
  end
end
