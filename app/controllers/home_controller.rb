class HomeController < ApplicationController
  def index
    @games = Game.current(Time.now).by_date.includes(:field, :visiting_team, :home_team => [:division])
  end
end

