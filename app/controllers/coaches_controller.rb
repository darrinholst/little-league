class CoachesController < ApplicationController
  def index
    @divisions = Division.includes(teams: [:coaches]).order('divisions.sort_order, teams.name').all
  end
end
