class Division < ActiveRecord::Base
  has_many :teams
  has_many :players
  has_many :coaches

  validates_presence_of :name
end

