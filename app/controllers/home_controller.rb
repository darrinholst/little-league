class HomeController < ApplicationController
  def index
    @games = Game.order(:starts_at).all
  end
end
