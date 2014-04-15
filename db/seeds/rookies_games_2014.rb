require 'csv'

teams_csv = <<-csv
Rookies,1-2 Grade,Perry,1,Cubs,,
Rookies,1-2 Grade,Perry,2,Rockies,,
Rookies,1-2 Grade,Perry,3,Braves,,
Rookies,1-2 Grade,Ogden,4,Royals,,
Rookies,1-2 Grade,Ogden,5,Cubs,,
Rookies,1-2 Grade,Greene Co.,6,Tigers,,
Rookies,1-2 Grade,Greene Co.,7,Marlins,,
Rookies,1-2 Grade,Greene Co.,8,Twins,,
Rookies,1-2 Grade,Greene Co.,9,White Sox,,
csv

teams = CSV.parse(teams_csv).map do |columns|
  Team.in_division(:rookies).name_matches("#{columns[2]}%#{columns[4]}") || Team.create! do |t|
    t.name = "#{columns[2]} #{columns[4]}"
    t.division = Division.name_matches(:rookies)
    t.local = false
  end
end

games_csv = <<-csv
4/29/14,5:45 PM,Rockies,2,vs,White Sox,9,Jefferson
4/29/14,7:00 PM,Braves,3,vs,Twins,8,Jefferson
4/29/14,6:00 PM,Marlins,7,vs,Royals,4,Ogden
5/1/14,6:00 PM,O-Cubs,5,vs,Tigers,6,Jefferson
5/1/14,6:00 PM,Marlins,7,vs,Rockies,2,Perry
5/6/14,5:45 PM,Braves,3,vs,Tigers,6,Jefferson
5/6/14,6:00 PM,O-Cubs,5,vs,Royals,4,Ogden
5/6/14,6:00 PM,Twins,8,vs,P-Cubs,1,Perry
5/6/14,7:00 PM,White Sox,9,vs,Twins,8,Jefferson
5/8/14,6:00 PM,Braves,3,vs,O-Cubs,5,Ogden
5/8/14,6:00 PM,P-Cubs,1,vs,Marlins,7,Jefferson
5/8/14,6:00 PM,Tigers,6,vs,Rockies,2,Perry
5/15/14,5:45 PM,Royals,4,vs,Braves,3,Perry
5/15/14,6:00 PM,White Sox,9,vs,Marlins,7,Jefferson
5/15/14,7:00 PM,Tigers,6,vs,P-Cubs,1,Perry
5/15/14,6:00 PM,Rockies,2,vs,O-Cubs,5,Ogden
5/19/14,5:45 PM,Twins,8,vs,Marlins,7,Jefferson
5/19/14,6:00 PM,Royals,4,vs,Rockies,2,Perry
5/19/14,6:00 PM,P-Cubs,1,vs,O-Cubs,5,Ogden
5/19/14,7:00 PM,Tigers,6,vs,White Sox,9,Jefferson
5/22/14,6:00 PM,Marlins,7,vs,O-Cubs,5,Ogden
5/22/14,5:45 PM,Rockies,2,vs,P-Cubs,1,Perry
5/22/14,6:00 PM,Royals,4,vs,Twins,8,Jefferson
5/22/14,7:00 PM,White Sox,9,vs,Braves,3,Perry
5/27/14,5:45 PM,O-Cubs,5,vs,White Sox,9,Jefferson
5/27/14,7:00 PM,Twins,8,vs,Tigers,6,Jefferson
5/27/14,6:00 PM,Braves,3,vs,Rockies,2,Perry
5/27/14,6:00 PM,P-Cubs,1,vs,Royals,4,Ogden
5/29/14,6:00 PM,Braves,3,vs,P-Cubs,1,Perry
5/29/14,6:00 PM,White Sox,9,vs,Royals,4,Ogden
5/29/14,5:45 PM,O-Cubs,5,vs,Twins,8,Jefferson
5/29/14,7:00 PM,Marlins,7,vs,Tigers,6,Jefferson
6/3/14,6:00 PM,Tigers,6,vs,Royals,4,Ogden
6/3/14,5:45 AM,P-Cubs,1,vs,White Sox,9,Jefferson
6/3/14,7:00 PM,Rockies,2,vs,Twins,8,Jefferson
6/3/14,6:00 PM,Marlins,7,vs,Braves,3,Perry
6/6/14,6:00 PM,Tigers,6,vs,O-Cubs,5,Ogden
6/6/14,5:45 PM,White Sox,9,vs,Rockies,2,Perry
6/6/14,7:00 PM,Twins,8,vs,Braves,3,Perry
6/6/14,6:00 PM,Royals,4,vs,Marlins,7,Jefferson
6/10/14,5:45 PM,P-Cubs,1,vs,Twins,8,Jefferson
6/10/14,7:00 PM,Rockies,2,vs,Marlins,7,Jefferson
6/10/14,6:00 PM,Tigers,6,vs,Braves,3,Perry
6/10/14,6:00 PM,Royals,4,vs,O-Cubs,5,Ogden
6/13/14,5:45 PM,Twins,8,vs,White Sox,9,Jefferson
6/13/14,5:45 PM,Marlins,7,vs,P-Cubs,1,Perry
6/13/14,7:00 PM,Rockies,2,vs,Tigers,6,Jefferson
6/13/14,7:00 PM,O-Cubs,5,vs,Braves,3,Perry
6/17/14,6:00 PM,O-Cubs,5,vs,Rockies,2,Perry
6/17/14,6:00 PM,Braves,3,vs,Royals,4,Ogden
6/17/14,5:45 PM,Marlins,7,vs,White Sox,9,Jefferson
6/17/14,7:00 PM,Cubs,1,vs,Tigers,6,Jefferson
6/20/14,5:45 PM,Braves,3,vs,White Sox,9,Jefferson
6/20/14,7:00 PM,O-Cubs,5,vs,Marlins,7,Jefferson
6/20/14,6:00 PM,P-Cubs,1,vs,Rockies,2,Perry
6/20/14,6:00 PM,Twins,8,vs,Royals,4,Ogden
6/24/14,5:45 PM,Royals,4,vs,P-Cubs,1,Perry
6/24/14,6:00 PM,White Sox,9,vs,O-Cubs,5,Ogden
6/24/14,6:00 PM,Tigers,6,vs,Twins,8,Jefferson
6/24/14,7:00 PM,Rockies,2,vs,Braves,3,Perry
6/27/14,6:00 PM,P-Cubs,1,vs,Braves,3,Perry
6/27/14,5:45 PM,Royals,4,vs,White Sox,9,Jefferson
6/27/14,6:00 PM,Twins,8,vs,O-Cubs,5,Ogden
6/27/14,7:00 PM,Tigers,6,vs,Marlins,7,Jefferson
6/30/14,5:45 PM,Braves,3,vs,Marlins,7,Jefferson
6/30/14,7:00 PM,Royals,4,vs,Tigers,6,Jefferson
6/30/14,5:45 PM,White Sox,9,vs,P-Cubs,1,Perry
6/30/14,7:00 PM,Twins,8,vs,Rockies,2,Perry
7/2/14,5:45 PM,White Sox,9,vs,Tigers,6,Jefferson
7/2/14,7:00 PM,Marlins,7,vs,Twins,8,Jefferson
7/2/14,6:00 PM,Rockies,2,vs,Royals,4,Ogden
7/2/14,6:00 PM,O-Cubs,5,vs,P-Cubs,1,Perry
csv

def field_for(name)
  name = "Perry Rookie" if name.match(/\Aperry\Z/i)
  Field.name_matches(name) || Field.create!(name: name)
end

Game.in_division(:rookies).delete_all

CSV.parse(games_csv).map do |columns|
  game = Game.new(
    starts_at: "#{columns[0]} #{columns[1]}",
    visiting_team: teams[columns[3].to_i - 1],
    home_team: teams[columns[6].to_i - 1],
    field: field_for(columns[7])
  )

  game.save! if game.includes_local_team?
end

