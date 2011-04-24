class AddOrderAndColorToDivisions < ActiveRecord::Migration
  def self.up
    add_column :divisions, :sort_order, :integer
    add_column :divisions, :color, :string

    update_division("Juniors", 1, '#668CD9')
    update_division("Majors", 2, '#AD2D2D')
    update_division("Minors", 3, '#4CB052')
    update_division("Rookies", 4, '#8C66D9')
    update_division("T-Ball", 5, '#D47F1E')
  end

  def self.down
  end

  def self.update_division(name, order, color)
    d = Division.find_by_name(name)

    if(d)
      d.sort_order = order
      d.color = color
      d.save!
    end
  end
end
