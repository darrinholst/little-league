class AddHeadCoachIndicator < ActiveRecord::Migration
  def change
    add_column :coaches, :head, :boolean, :default => false
  end
end
