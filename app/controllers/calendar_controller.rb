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
        :color => game.division_color,
        :division => game.division_name
      }
    end
  end

  def ical
    calendar = RiCal.Calendar do |cal|
      Game.all.map do |game|
        cal.event do |event|
          event.summary "#{game.visiting_team.name} at #{game.home_team.name}"
          event.dtstart game.starts_at
          event.dtend game.starts_at + 90.minutes
          event.location game.field.name
        end
      end
    end

    render :text => calendar.export
  end
end
