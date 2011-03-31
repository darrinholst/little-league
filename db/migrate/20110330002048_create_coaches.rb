class CreateCoaches < ActiveRecord::Migration
  def self.up
    create_table :coaches do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email_address
      t.integer :division_id
      t.integer :team_id
      t.timestamps
    end
  end

  def self.down
    drop_table :coaches
  end
end
