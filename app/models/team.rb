class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
  has_many :coaches
end
