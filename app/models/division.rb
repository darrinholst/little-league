class Division < ActiveRecord::Base
  default_scope :order => "sort_order ASC"

  has_many :teams
  has_many :players

  validates_presence_of :name
end
