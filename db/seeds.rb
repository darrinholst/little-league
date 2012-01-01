# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Division.create!(:name => "T-Ball" , :sort_order => 5, :color => "#D47F1E")
Division.create!(:name => "Rookies", :sort_order => 4, :color => "#8C66D9")
Division.create!(:name => "Minors" , :sort_order => 3, :color => "#4CB052")
Division.create!(:name => "Majors" , :sort_order => 2, :color => "#AD2D2D")
Division.create!(:name => "Juniors", :sort_order => 1, :color => "#668CD9")

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

Field.create!(:name => "Rookie")
Field.create!(:name => "Minor")
Field.create!(:name => "Major")
