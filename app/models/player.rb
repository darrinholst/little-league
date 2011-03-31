class Player < ActiveRecord::Base
  CUTOFF_DATE = Chronic.parse("04/30/2011")

  belongs_to :division
  belongs_to :team

  def name
    "#{first_name} #{last_name}"
  end

  def division_name
    division ? division.name : ""
  end

  def team_name
    team ? team.name : ""
  end

  def birthdate=(birthdate)
    date = Chronic.parse(birthdate)
    write_attribute(:birthdate, date.to_date) if date
  end

  def age
    if birthdate
      CUTOFF_DATE.year - birthdate.year - ((CUTOFF_DATE.month > birthdate.month || (CUTOFF_DATE.month == birthdate.month && CUTOFF_DATE.day >= birthdate.day)) ? 0 : 1)
    end
  end
end
