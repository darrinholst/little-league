require 'csv'

teams_csv = <<-csv
Majors,5-6 Grade,Perry,1,Mets,,
Majors,5-6 Grade,Perry,2,Dodgers,,
Majors,5-6 Grade,Greene Co.,3,Diamondbacks,,
Majors,5-6 Grade,Greene Co.,4,Cardinals,,
Majors,5-6 Grade,Ogden,5,Red Sox,,
Majors,5-6 Grade,Ogden,6,Reds,,
csv

teams = CSV.parse(teams_csv).map do |columns|
  Team.in_division(:majors).name_matches("#{columns[2]}%#{columns[4]}") || Team.create! do |t|
    t.name = "#{columns[2]} #{columns[4]}"
    t.division = Division.name_matches(:majors)
    t.local = false
  end
end

games_csv = <<-csv
4/29/14,6:00 PM,Diamondbacks,3,vs,Cardinals,4,Jefferson
4/29/14,6:00 PM,Red Sox,5,vs,Reds,6,Ogden
5/1/14,6:00 PM,Mets,1,vs,Dodgers,2,Perry
5/6/14,6:00 PM,Red Sox,5,vs,Cardinals,4,Jefferson
5/6/14,6:00 PM,Mets,1,vs,Reds,6,Ogden
5/6/14,6:00 PM,Diamondbacks,3,vs,Dodgers,2,Perry
5/15/14,6:00 PM,Diamondbacks,3,vs,Mets,1,Perry
5/15/14,7:30 PM,Dodgers,2,vs,Red Sox,5,Ogden
5/15/14,7:30 PM,Reds,6,vs,Cardinals,4,Jefferson
5/20/14,7:30 PM,Dodgers,2,vs,Reds,6,Ogden
5/20/14,6:00 PM,Cardinals,4,vs,Mets,1,Perry
5/20/14,7:30 PM,Red Sox,5,vs,Diamondbacks,3,Jefferson
5/27/14,7:30 PM,Mets,1,vs,Red Sox,5,Ogden
5/27/14,7:30 PM,Reds,6,vs,Diamondbacks,3,Jefferson
5/27/14,6:00 PM,Cardinals,4,vs,Dodgers,2,Perry
5/30/14,7:30 PM,Cardinals,4,vs,Diamondbacks,3,Jefferson
5/30/14,7:30 PM,Reds,6,vs,Red Sox,5,Ogden
5/30/14,6:00 PM,Dodgers,2,vs,Mets,1,Perry
6/3/14,6:00 PM,Reds,6,vs,Mets,1,Perry
6/3/14,7:30 PM,Dodgers,2,vs,Diamondbacks,3,Jefferson
6/3/14,7:30 PM,Cardinals,4,vs,Red Sox,5,Ogden
6/6/14,6:00 PM,Red Sox,5,vs,Dodgers,2,Perry
6/6/14,6:00 PM,Cardinals,4,vs,Reds,6,Ogden
6/6/14,7:30 PM,Mets,1,vs,Diamondbacks,3,Jefferson
6/10/14,7:30 PM,Mets,1,vs,Cardinals,4,Jefferson
6/10/14,7:30 PM,Diamondbacks,3,vs,Red Sox,5,Ogden
6/10/14,6:00 PM,Reds,6,vs,Dodgers,2,Perry
6/13/14,6:00 PM,Diamondbacks,3,vs,Reds,6,Ogden
6/13/14,7:30 PM,Dodgers,2,vs,Cardinals,4,Jefferson
6/13/14,6:00 PM,Red Sox,5,vs,Mets,1,Perry
6/17/14,7:30 PM,Red Sox,5,vs,Reds,6,Ogden
6/17/14,6:00 PM,Mets,1,vs,Dodgers,2,Perry
6/17/14,7:30 PM,Diamondbacks,3,vs,Cardinals,4,Jefferson
6/20/14,6:00 PM,Dodgers,2,vs,Diamondbacks,3,Jefferson
6/20/14,7:30 PM,Red Sox,5,vs,Cardinals,4,Jefferson
6/20/14,7:30 PM,Mets,1,vs,Reds,6,Ogden
6/24/14,7:30 PM,Reds,6,vs,Cardinals,4,Jefferson
6/24/14,6:00 PM,Diamondbacks,3,vs,Mets,1,Perry
6/24/14,7:30 PM,Mets,1,vs,Red Sox,5,Ogden
6/27/14,7:30 PM,Red Sox,5,vs,Diamondbacks,3,Jefferson
6/27/14,7:30 PM,Dodgers,2,vs,Reds,6,Ogden
6/27/14,6:00 PM,Cardinals,4,vs,Mets,1,Perry
6/30/14,6:00 PM,Cardinals,4,vs,Dodgers,2,Perry
6/30/14,7:30 PM,Mets,1,vs,Red Sox,5,Ogden
6/30/14,7:30 PM,Reds,6,vs,Diamondbacks,3,Jefferson
csv

def field_for(name)
  name = "Perry Major" if name.match(/\Aperry\Z/i)
  Field.name_matches(name) || Field.create!(name: name)
end

Game.in_division(:majors).delete_all

CSV.parse(games_csv).map do |columns|
  game = Game.new(
    starts_at: "#{columns[0]} #{columns[1]}",
    visiting_team: teams[columns[3].to_i - 1],
    home_team: teams[columns[6].to_i - 1],
    field: field_for(columns[7])
  )

  game.save! if game.includes_local_team?
end

