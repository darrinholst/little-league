# [
#   {
#     "title": "Opening Ceremonies",
#     "start": "<%= Timeliness.parse("04/30/2011 12:00:00", :zone => Time.zone).iso8601 %>",
#     "allDay": false
#   }
# ]
class CalendarController < ApplicationController
  def home
    @games = Game.includes([{:home_team => :division}, :visiting_team]).order("divisions.name")

    if(params[:start] && params[:end])
      @games = @games.where(['starts_at >= ? and starts_at <= ?', Time.at(params[:start].to_i), Time.at(params[:end].to_i)])
    end

    @games = @games.all.map do |game|
      {
        :title => "#{game.visiting_team.name} at #{game.home_team.name}",
        :start => game.starts_at.iso8601,
        :allDay => false,
        :color => color_for(game.division_name),
        :division => game.division_name
      }
    end
  end

  private

  def color_for(division)
    case division
      when /t-ball/i then '#D47F1E'
      when /rookies/i then '#8C66D9'
      when /minors/i then '#4CB052'
      when /majors/i then '#AD2D2D'
      else '#668CD9'
    end
  end
end
