ActiveAdmin.register Team do
  permit_params :name, :division_id, :local
  config.sort_order = '!'

  member_action :concessionable_players, :method => :get do
    render json: Team.find(params[:id]).concessionable_players.map {|p| {id: p.id, name: p.name}}
  end

  controller do
    def scoped_collection
      Team.includes(:division).order('divisions.sort_order desc, teams.name asc')
    end
  end

  index do
    column :division, sortable: 'divisions.sort_order'
    column :name do |resource| link_to resource.name, resource_path(resource) end
    column :local
    actions :defaults => false do |resource|
      links = ''.html_safe
      links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
      links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
      links
    end
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
      i = 0
      column '' do |r| i += 1 end
      column :name do |player| link_to player.name, edit_admin_player_path(player) end
      column 'Birthdate', :birthdate_display
      column :age
      column :parents
      column 'Phone', :phone_number
      column 'Alternate Phone', :alternate_phone_number
      column 'Shirt', :shirt_size
      column 'Concessions Exempt?', :concessions_exempt do |r| editable_check_box_column(r, :concessions_exempt) end
    end
  end

  filter :division
  filter :local
end
