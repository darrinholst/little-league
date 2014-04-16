class AddConcessionExempt < ActiveRecord::Migration
  def change
    add_column :players, :concessions_exempt, :boolean, :default => false
  end
end
