ActiveAdmin.register Division do
  config.filters = false
  config.sort_order = '!'

  controller do
    def scoped_collection
      Division.order('sort_order desc')
    end
  end

  index do
    column :name do |resource| link_to resource.name, resource_path(resource) end
    actions :defaults => false do |resource|
      links = ''.html_safe
      links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
      links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
      links
    end
  end

  show do
    h3 'Coaches'
    table_for resource.coaches.by_team, class: 'index_table' do
      i = 0
      column '' do |r| i += 1 end
      column :team
      column :name do |coach| link_to coach.name, edit_admin_coach_path(coach) end
      column 'Phone', :phone_number
      column 'Email', :email_address
    end

    br

    h3 'Players'
    table_for resource.players.by_team, class: 'index_table' do
      i = 0
      column '' do |r| i += 1 end
      column :team
      column :name do |player| link_to player.name, edit_admin_player_path(player) end
      column 'Birthdate', :birthdate_display
      column :age
      column :parents
      column 'Phone', :phone_number
      column 'Alternate Phone', :alternate_phone_number
      column 'Shirt', :shirt_size
    end
  end
end
