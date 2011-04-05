class Game < ActiveRecord::Base
  belongs_to :visiting_team, :class_name => 'Team'
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :field

  validates_presence_of :home_team, :visiting_team
  validate :teams_are_in_the_same_division

  def field_name
    field ? field.name : nil
  end

  private

  def teams_are_in_the_same_division
    if visiting_team && home_team
      errors.add(:base, "Teams must be in the same division") unless visiting_team.division.name.eql? home_team.division.name
    end
  end
end
