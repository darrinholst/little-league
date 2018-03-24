class CalendarController < ApplicationController
  def home
    @games = Game.includes([:field, {:home_team => :division}, :visiting_team]).order("divisions.name")

    if (params[:start] && params[:end])
      @games = @games.where(['starts_at >= ? and starts_at <= ?', Time.at(params[:start].to_i), Time.at(params[:end].to_i)])
    end

    @games = @games.all.sort{|a, b| a.division_name <=> b.division_name}.each_with_index.map do |game, i|
      {
        :title => "#{game.visiting_team.name} at #{game.home_team.name} (#{game.field.name})",
        :start => (game.starts_at + i.seconds).iso8601,
        :allDay => false,
        :color => game.division_color,
        :division => game.division_name,
        :in_town => game.in_town?,
        :on_click => current_user && current_user.admin? && edit_admin_game_url(game)
      }
    end

    @games << {
      title: 'Closing Ceremonies',
      start: Chronic.parse('06/12/2016 2pm').iso8601,
      allDay: false,
      color: '#0f389e',
      in_town: true
    }

    @games = [] unless ENV['GAMES_PUBLIC'] || (current_user && current_user.admin?)
  end

  def ical
    team = Team.find(params[:team_id])
    name =  "#{team.name} Baseball"
    render :text => build_calendar(team.games, name)
  end

  def local_ical
    games = Game.local.includes(:field, :home_team, :visiting_team)
    render :text => build_calendar(games, 'Perry Little League Baseball')
  end

  private

  def build_calendar(games, name)
    RiCal.Calendar do |cal|
      cal.add_x_property 'X-WR-CALNAME', name

      games.each do |game|
        cal.event do |event|
          event.summary "#{game.visiting_team.name} at #{game.home_team.name}"
          event.dtstart game.starts_at
          event.dtend game.starts_at + 90.minutes
          event.location "#{game.field.name} Field"
        end
      end
    end.export
  end
end
