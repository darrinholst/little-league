class HomeController < ApplicationController
  def index
    @games = Game.order(:starts_at).all(:include => [
      :visiting_team,
      :home_team => [:division]
    ])
  end
end
