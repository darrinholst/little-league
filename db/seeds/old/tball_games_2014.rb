require 'csv'

games_csv = <<-csv
5/10 10:30 AM,Indians,Pirates,Perry Rookie
5/10 10:30 AM,Royals,Yankees,Perry Minor
5/16 6:00 PM,Royals,Indians,Perry Rookie
5/16 6:00 PM,Yankees,Pirates,Perry Minor
5/20 5:45 PM,Pirates,Royals,Perry Rookie
5/20 7:00 PM,Indians,Yankees,Perry Rookie
5/30 5:45 PM,Royals,Yankees,Perry Rookie
5/30 7:00 PM,Pirates,Indians,Perry Rookie
6/2 6:00 PM,Yankees,Pirates,Perry Rookie
6/2 6:00 PM,Indians,Royals,Perry Minor
6/9 6:00 PM,Indians,Yankees,Perry Rookie
6/9 6:00 PM,Royals,Pirates,Perry Minor
6/14 10:30 AM,Pirates,Indians,Perry Rookie
6/14 10:30 AM,Yankees,Royals,Perry Minor
6/21 10:30 AM,Indians,Royals,Perry Rookie
6/21 10:30 AM,Pirates,Yankees,Perry Minor
6/28 10:30 AM,Royals,Pirates,Perry Rookie
6/28 10:30 AM,Yankees,Indians,Perry Minor
csv

def field_for(name)
  Field.name_matches(name) || Field.create!(name: name)
end

def team_for(name)
  Team.in_division('t-ball').name_matches(name)
end

Game.in_division('t-ball').delete_all

CSV.parse(games_csv).map do |columns|
  game = Game.new(
    starts_at: columns[0],
    visiting_team: team_for(columns[1]),
    home_team: team_for(columns[2]),
    field: field_for(columns[3])
  )

  game.save!
end

