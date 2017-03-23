class HomeController < ApplicationController
  def index
    @games = Game.current(Time.now).by_date.includes(:field, :visiting_team, :home_team => [:division])
    @games = [] unless ENV['GAMES_PUBLIC']
  end
end

