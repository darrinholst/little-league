class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.timestamp :starts_at
      t.integer :visiting_team_id
      t.integer :home_team_id
      t.integer :field_id
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
