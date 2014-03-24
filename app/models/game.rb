class Game < ActiveRecord::Base
  belongs_to :visiting_team, :class_name => 'Team'
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :field

  validates_presence_of :home_team, :visiting_team, :field, :starts_at
  validate :teams_are_in_the_same_division

  def in_town?
    home_team.local?
  end

  def division_name
    home_team.division.name
  end

  def division_color
    home_team.division.color
  end

  def field_name
    field ? field.name : nil
  end

  def starts_at_display
    starts_at.strftime("%a %b %d %l:%M %p").gsub(/ {2,}/, " ") if starts_at
  end

  def starts_at_form
    starts_at.strftime("%m/%d/%Y %l:%M%P").gsub(/ {2,}/, " ") if starts_at
  end

  def starts_at=(date)
    parsed = Chronic.parse(date.gsub(/ 0/, " "))
    write_attribute(:starts_at, parsed.utc) if parsed
  end

  scope :current, where("starts_at >= ?", Date.today)
  scope :by_date, order("starts_at")

  private

  def teams_are_in_the_same_division
    if visiting_team && home_team
      errors.add(:base, "Teams must be in the same division") unless visiting_team.division.name.eql? home_team.division.name
    end
  end
end

