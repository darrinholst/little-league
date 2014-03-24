class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
  has_many :coaches
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'visiting_team_id'

  validates_presence_of :name

  def games
    [home_games, away_games].flatten.sort {|x,y| x.starts_at <=> y.starts_at }
  end

  def self.all_local
    Team.where(local: true).all
  end
end

