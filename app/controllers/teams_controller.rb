class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:division).order("division_id, name").all
  end

  def show
    @team = Team.find(params[:id])
  end
end
