require 'csv'

games_csv = <<-csv
4/21/14 6pm,false,Ames 2
4/24/14 6pm,true,Madrid
5/2/14 6pm,false,Ames Grey
5/5/14 6pm,false,DCG
5/8/14 7pm,false,Granger
5/15/14 6pm,true,DCG
5/16/14 6pm,true,Ames 2
5/19/14 6pm,true,Granger
5/23/14 6pm,false,DCG
5/29/14 6pm,true,Madrid
5/30/14 6pm,false,Ames Grey
6/2/14 6pm,true,Ames 2
6/6/14 6pm,false,Granger
6/9/14 6pm,true,Ames Grey
6/10/14 6pm,false,Madrid
csv

def field_for(name)
  name = "Perry Junior" if name.match(/\Aperry\Z/i)
  Field.name_matches(name) || Field.create!(name: name)
end

def team_for(name)
  Team.in_division(:juniors).name_matches(name + '%') || Team.create! do |t|
    t.name = name
    t.division = Division.name_matches(:juniors)
    t.local = false
  end
end

Game.in_division(:juniors).delete_all

CSV.parse(games_csv).map do |columns|
  is_home_game = columns[1] == 'true'

  game = Game.new(
    starts_at: columns[0],
    visiting_team: (is_home_game ? team_for(columns[2]) : team_for('perry')),
    home_team: (is_home_game ? team_for('perry') : team_for(columns[2])),
    field: (is_home_game ? field_for('perry') : field_for(columns[2]))
  )

  game.save! if game.includes_local_team?
end

