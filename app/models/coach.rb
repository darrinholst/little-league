class Coach < ActiveRecord::Base
  belongs_to :division
  belongs_to :team

  scope :ordered, -> { order('head desc') }

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
