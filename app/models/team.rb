class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
  has_many :coaches

  validates_presence_of :name
end
