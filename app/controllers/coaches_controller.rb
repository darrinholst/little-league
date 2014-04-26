class CoachesController < ApplicationController
  def index
    @divisions = Division.includes(teams: [:coaches]).references(:teams).order('divisions.sort_order, teams.name')
  end
end
