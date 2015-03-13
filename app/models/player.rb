class Player < ActiveRecord::Base
  CUTOFF_DATE = Chronic.parse("04/30/2015")

  belongs_to :division
  belongs_to :team

  validates_presence_of :first_name
  validates_presence_of :last_name

  scope :youngest_first, -> { order('birthdate desc') }
  scope :by_team, -> { includes(:team).order('teams.name, birthdate desc') }
  scope :available_for_concessions, -> { where(concessions_exempt: false) }

  def concessions_count
    Game.where('home_team_concessions_1_id = ? or home_team_concessions_2_id = ? or visiting_team_concessions_1_id = ? or visiting_team_concessions_2_id = ?', id, id, id, id).count
  end

  def umpire_count
    Game.where('home_plate_umpire_id = ? or base_umpire_id = ?', id, id).count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def division_name
    division ? division.name : ""
  end

  def team_name
    team ? team.name : ""
  end

  def birthdate_display
    birthdate.strftime('%m/%d/%Y') rescue ''
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

  def shirt_size=(shirt_size)
    write_attribute(:shirt_size, shirt_size.upcase)
  end
end

