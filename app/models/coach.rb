class Coach < ActiveRecord::Base
  belongs_to :division
  belongs_to :team

  validates_presence_of :first_name
  validates_presence_of :last_name

  scope :ordered, -> { order('head desc') }
  scope :by_team, -> { includes(:team).order('teams.name, head desc') }

  def name
    "#{first_name} #{last_name}"
  end

  def division_name
    division ? division.name : ""
  end

  def team_name
    team ? team.name : ""
  end
end

