class Division < ActiveRecord::Base
  has_many :teams, -> { order('name') }
  has_many :players
  has_many :coaches

  validates_presence_of :name

  def self.name_matches(q)
    where(arel_table[:name].matches(q)).first
  end

  def number
    case name
      when 'T-Ball'
        11
      when 'Rookies'
        12
      when 'Minors'
        12
      when 'Majors'
        13
      when 'Juniors'
        17
    end
  end
end

