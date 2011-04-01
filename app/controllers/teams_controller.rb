class TeamsController < ApplicationController
  def index
    @divisions = Division.includes(:teams).all
  end

  def show
    @team = Team.find(params[:id])
  end
end
