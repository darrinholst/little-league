ActiveAdmin.register Team do
  config.sort_order = '!!!!GRRRR, I WILL JUST HANDLE IT MYSELF. GOOD FUCKING GOD!!!!'

  controller do
    def scoped_collection
      Team.includes(:division).order('divisions.sort_order desc, teams.name asc')
    end
  end

  index do
    column :division, sortable: 'divisions.sort_order' do |r| r.division.name end
    column :name
    column :local
    default_actions
  end

  filter :division
  filter :local
end
