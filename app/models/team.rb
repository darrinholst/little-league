class Team < ActiveRecord::Base
  belongs_to :division
  has_many :players
  has_many :coaches
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'visiting_team_id'

  validates_presence_of :name

  scope :in_division, ->(name) {where(division_id: Division.name_matches(name))}
  scope :local, -> {where(local: true)}

  def concessionable_players
    players.available_for_concessions
  end

  def self.name_matches(q)
    where(arel_table[:name].matches(q)).first
  end

  def games
    [home_games, away_games].flatten.sort {|x,y| x.starts_at <=> y.starts_at }
  end

  def self.all_local
    Team.where(local: true).all
  end
end

