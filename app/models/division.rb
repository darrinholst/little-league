class Division < ActiveRecord::Base
  has_many :teams
  has_many :players

  validates_presence_of :name
end
