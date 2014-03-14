class Coach < ActiveRecord::Base
  belongs_to :division
  belongs_to :team

  default_scope :order => "head DESC"

  def division_name
    division ? division.name : ""
  end

  def team_name
    team ? team.name : ""
  end
end
