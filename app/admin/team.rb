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

  show do
    h3 'Coaches'
    table_for resource.coaches.ordered, class: 'index_table' do
      column :name do |coach| link_to coach.name, edit_admin_coach_path(coach) end
      column 'Phone', :phone_number
      column 'Email', :email_address
    end

    br

    h3 'Players'
    table_for resource.players.youngest_first, class: 'index_table' do
      column :name do |player| link_to player.name, edit_admin_player_path(player) end
      column 'Birthdate', :birthdate_display
      column :age
      column :parents
      column 'Phone', :phone_number
      column 'Alternate Phone', :alternate_phone_number
      column 'Shirt', :shirt_size
    end
  end

  filter :division
  filter :local
end
