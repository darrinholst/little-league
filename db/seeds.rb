# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

names = [
  ["Lance", "Candy"],
  ["Lance", "Schuetz"],
  ["Ted", "Legnon"],
  ["Jessie", "Kohen"],
  ["Clayton", "Goll"],
  ["Darren", "Cloe"],
  ["Clayton", "Gumbs"],
  ["Jessie", "Vivanco"],
  ["Kurt", "Lamboy"],
  ["Guy", "Engles"],
  ["Fernando", "Gallager"],
  ["Darren", "Anstett"],
  ["Allan", "Phillippe"],
  ["Lonnie", "Papageorge"],
  ["Nelson", "Devilbiss"],
  ["Jamie", "Reetz"],
  ["Clinton", "Bradly"],
  ["Hugh", "Kennamer"],
  ["Darren", "Dory"],
  ["Erik", "Jeong"],
  ["Clayton", "Benito"],
  ["Clayton", "Saint"],
  ["Julio", "Schluter"],
  ["Max", "Schroth"],
  ["Lonnie", "Buser"],
  ["Lonnie", "Carico"],
  ["Kelly", "Nally"],
  ["Neil", "Copland"],
  ["Jessie", "Grignon"],
  ["Darren", "Pen"],
  ["Lance", "Mcnear"],
  ["Erik", "Guan"],
  ["Mathew", "Shain"],
  ["Javier", "Baillie"],
  ["Clinton", "Philbeck"],
  ["Tyrone", "Agular"],
  ["Mathew", "Ostrowski"],
  ["Jamie", "Pascoe"],
  ["Tyrone", "Urso"],
  ["Javier", "Butera"],
  ["Erik", "Geddie"],
  ["Javier", "Meadow"],
  ["Fernando", "Shack"],
  ["Guy", "Cudjoe"],
  ["Tyrone", "Dille"],
  ["Julio", "Breed"],
  ["Jessie", "Strayhorn"],
  ["Kurt", "Jen"],
  ["Clayton", "Mattera"],
  ["Guy", "Salzman"],
  ["Allan", "Villicana"],
  ["Javier", "Dunklin"],
  ["Max", "Pharris"],
  ["Max", "Casagrande"],
  ["Jessie", "Frankum"],
  ["Lonnie", "Harries"],
  ["Allan", "Markowski"],
  ["Ted", "Swaby"],
  ["Mathew", "Ashlock"],
  ["Lance", "Vester"],
  ["Scott", "Olsen"]
]

teams = Team.all
player_counter = 0

teams.each do |team|
  4.times do
    Player.create!(:first_name => names[player_counter].first, :last_name => names[player_counter].second, :team => team, :division => team.division)
    player_counter += 1
  end
end
