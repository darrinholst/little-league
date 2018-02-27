desc 'distribute players to division by age'
task :distribute => :environment do
  tball = Division.find_by_name("T-Ball")
  rookies = Division.find_by_name("Rookies")
  minors = Division.find_by_name("Minors")
  majors = Division.find_by_name("Majors")
  juniors = Division.find_by_name("Juniors")

  Player.all.each do |player|
    if player.age
      division = nil

      case player.age
        when 4, 5, 6
          division = tball
        when 7, 8
          division = rookies
        when 9, 10
          division = minors
        when 11, 12
          division = majors
        when 13, 14, 15
          division = juniors
      end

      player.update_attributes!(:division_id => division.id) if division
    end
  end
end
