class Division < ActiveRecord::Base
  has_many :teams
  has_many :players
  has_many :coaches

  validates_presence_of :name

  def self.name_matches(q)
    where(arel_table[:name].matches(q)).first
  end
end

