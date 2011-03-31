class SeedTeams < ActiveRecord::Migration
  def self.up
    Team.create!(:name => "Angels", :division => Division.find_by_name("T-Ball"))
    Team.create!(:name => "Pirates", :division => Division.find_by_name("T-Ball"))
    Team.create!(:name => "Royals", :division => Division.find_by_name("T-Ball"))
    Team.create!(:name => "Yankees", :division => Division.find_by_name("T-Ball"))

    Team.create!(:name => "Braves", :division => Division.find_by_name("Rookies"))
    Team.create!(:name => "Cubs", :division => Division.find_by_name("Rookies"))
    Team.create!(:name => "Reds", :division => Division.find_by_name("Rookies"))
    Team.create!(:name => "Rockies", :division => Division.find_by_name("Rookies"))

    Team.create!(:name => "Diamond Backs", :division => Division.find_by_name("Minors"))
    Team.create!(:name => "Indians", :division => Division.find_by_name("Minors"))
    Team.create!(:name => "Phillies", :division => Division.find_by_name("Minors"))

    Team.create!(:name => "Dodgers", :division => Division.find_by_name("Majors"))
    Team.create!(:name => "Mets", :division => Division.find_by_name("Majors"))
    Team.create!(:name => "Twins", :division => Division.find_by_name("Majors"))
  end

  def self.down
  end
end
