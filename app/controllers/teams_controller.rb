class TeamsController < ApplicationController
  def index
    @divisions = Division.includes(:teams).all
  end

  def show
    @team = Team.includes(:division, :home_games, :away_games).find(params[:id])
  end
end
