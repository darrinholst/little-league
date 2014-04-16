require 'csv'

teams_csv = <<-csv
Minors,3-4 Grade,Perry,1,Phillies,,
Minors,3-4 Grade,Perry,2,Orioles,,
Minors,3-4 Grade,Greene Co.,3,Red Sox,,
Minors,3-4 Grade,Greene Co.,4,Yankees,,
Minors,3-4 Grade,Greene Co.,5,Cubs,,
Minors,3-4 Grade,Ogden,6,A's,,
Minors,3-4 Grade,Ogden,7,Braves,,
csv

teams = CSV.parse(teams_csv).map do |columns|
  Team.in_division(:minors).name_matches("#{columns[2]}%#{columns[4]}") || Team.create! do |t|
    t.name = "#{columns[2]} #{columns[4]}"
    t.division = Division.name_matches(:minors)
    t.local = false
  end
end

games_csv = <<-csv
5/1/14,6:00 PM,Phillies,1,VS,Orioles,2,Perry
5/1/14,6:00 PM,Red Sox,3,VS,Yankees,4,Jefferson
5/1/14,6:00 PM,Cubs,5,VS,A's,6,Ogden
5/8/14,6:00 PM,Cubs,5,VS,Braves,7,Ogden
5/8/14,6:00 PM,Orioles,2,VS,Yankees,4,Jefferson
5/8/14,6:00 PM,Red Sox,3,VS,Phillies,1,Perry
5/15/14,6:00 PM,Cubs,5,VS,Yankees,4,Jefferson
5/15/14,6:00 PM,Red Sox,3,VS,Braves,7,Ogden
5/15/14,6:00 PM,A's,6,VS,Orioles,2,Perry
5/20/14,6:00 PM,Red Sox,3,VS,A's,6,Ogden
5/20/14,6:00 PM,Braves,7,VS,Orioles,2,Perry
5/20/14,6:00 PM,Phillies,1,VS,Cubs,5,Jefferson
5/22/14,6:00 PM,Braves,7,VS,Phillies,1,Perry Major
5/22/14,6:00 PM,Yankees,4,VS,A's,6,Ogden
5/22/14,6:00 PM,Orioles,2,VS,Cubs,5,Jefferson
5/27/14,6:00 PM,Orioles,2,VS,Red Sox,3,Jefferson
5/27/14,6:00 PM,Yankees,4,VS,Phillies,1,Perry
5/27/14,6:00 PM,A's,6,VS,Braves,7,Ogden
5/30/14,6:00 PM,Yankees,4,VS,Braves,7,Ogden
5/30/14,6:00 PM,A's,6,VS,Phillies,1,Perry
5/30/14,6:00 PM,Red Sox,3,VS,Cubs,5,Jefferson
6/3/14,6:00 PM,Yankees,4,VS,Red Sox,3,Jefferson
6/3/14,6:00 PM,Orioles,2,VS,Phillies,1,Perry
6/3/14,6:00 PM,Cubs,5,VS,A's,6,Ogden
6/6/14,6:00 PM,Cubs,5,VS,Red Sox,3,Jefferson
6/10/14,6:00 PM,Phillies,1,VS,Red Sox,3,Jefferson
6/13/14,6:00 PM,Braves,7,VS,Cubs,5,Jefferson
6/13/14,6:00 PM,Yankees,4,VS,Orioles,2,Perry
6/17/14,6:00 PM,Yankees,4,VS,Cubs,5,Jefferson
6/17/14,6:00 PM,A's,6,VS,Orioles,2,Perry
6/17/14,6:00 PM,Red Sox,3,VS,Braves,7,Ogden
6/20/14,6:00 PM,Braves,7,VS,Orioles,2,Perry Major
6/20/14,6:00 PM,Red Sox,3,VS,A's,6,Ogden
6/20/14,6:00 PM,Cubs,5,VS,Phillies,1,Perry
6/24/14,6:00 PM,A's,6,VS,Yankees,4,Jefferson
6/24/14,6:00 PM,Phillies,1,VS,Braves,7,Ogden
6/24/14,6:00 PM,Cubs,5,VS,Orioles,2,Perry
6/27/14,6:00 PM,Red Sox,3,VS,Orioles,2,Perry
6/27/14,6:00 PM,Braves,7,VS,A's,6,Ogden
6/27/14,6:00 PM,Phillies,1,VS,Yankees,4,Jefferson
6/30/14,6:00 PM,Phillies,1,VS,A's,6,Ogden
6/30/14,6:00 PM,Braves,7,VS,Yankees,4,Jefferson
6/30/14,6:00 PM,Cubs,5,VS,Red Sox,3,Jefferson
csv

def field_for(name)
  name = "Perry Minor" if name.match(/\Aperry\Z/i)
  Field.name_matches(name) || Field.create!(name: name)
end

Game.in_division(:minors).delete_all

CSV.parse(games_csv).map do |columns|
  game = Game.new(
    starts_at: "#{columns[0]} #{columns[1]}",
    visiting_team: teams[columns[3].to_i - 1],
    home_team: teams[columns[6].to_i - 1],
    field: field_for(columns[7])
  )

  game.save! if game.includes_local_team?
end


