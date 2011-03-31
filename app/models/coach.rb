class Coach < ActiveRecord::Base
  belongs_to :division
  belongs_to :team

  def division_name
    division ? division.name : ""
  end

  def team_name
    team ? team.name : ""
  end
end
