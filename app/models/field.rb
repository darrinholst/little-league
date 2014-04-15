class Field < ActiveRecord::Base
  validates_presence_of :name

  def self.name_matches(q)
    where(arel_table[:name].matches(q)).first
  end
end

