class DeviseTwoPointOh < ActiveRecord::Migration
  def up
    remove_column :users, :remember_token
    add_column :users, :reset_password_sent_at, :timestamp
  end

  def down
  end
end
