desc "clean up data"
task "data:cleanup" => :environment do
  Player.all.each do |player|
    player.phone_number = player.phone_number.gsub(/^515-/, "") if player.phone_number
    player.alternate_phone_number = player.alternate_phone_number.gsub(/^515-/, "") if player.alternate_phone_number
    player.parents = player.parents.gsub(/ *\/ */, "/") if player.parents
    player.save!
  end
end
