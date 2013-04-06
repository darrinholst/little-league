class HomeController < ApplicationController
  def index
    @games = Game.current.by_date.all(:include => [
      :field,
      :visiting_team,
      :home_team => [:division]
    ])
  end
end
