class AddConcessionsAndUmpiresCrap < ActiveRecord::Migration
  def change
    add_column :games, :home_team_concessions_1_id, :integer, references: :players
    add_column :games, :home_team_concessions_2_id, :integer, references: :players
    add_column :games, :visiting_team_concessions_1_id, :integer, references: :players
    add_column :games, :visiting_team_concessions_2_id, :integer, references: :players
    add_column :games, :home_plate_umpire_id, :integer, references: :players
    add_column :games, :base_umpire_id, :integer, references: :players
  end
end
