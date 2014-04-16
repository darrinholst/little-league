teams = {}

Team.all.each do |team|
  if team.local?
    teams[team] = {
      next_player_index: 0,
      players: team.concessionable_players.all,
      needs_home_plate_umpire: team.division.name.match(/rookies/i),
      needs_base_umpire: team.division.name.match(/rookies|minors|majors/i)
    }
  end
end

def next_player_for(team)
  players = team[:players]
  current_index = team[:next_player_index]
  next_index = current_index + 1
  team[:next_player_index] = next_index < players.size ? next_index : 0
  players[current_index]
end

Game.includes(:home_team, :visiting_team).each do |game|
  if game.in_town?
    home_team = teams[game.home_team]
    visiting_team = teams[game.visiting_team]

    game.home_team_concessions_1 = next_player_for(home_team)
    game.home_team_concessions_2 = next_player_for(home_team)

    if visiting_team
      game.visiting_team_concessions_1 = next_player_for(visiting_team)
      game.visiting_team_concessions_2 = next_player_for(visiting_team)
    end

    if home_team[:needs_home_plate_umpire]
      game.home_plate_umpire = next_player_for(home_team)
    end

    if home_team[:needs_base_umpire]
      game.base_umpire = next_player_for(home_team)
    end

    game.save!
  end
end
