ActiveAdmin.register Team do
  permit_params :name, :division_id, :local
  config.sort_order = '!'

  before_filter :only => [:index] do
    if request.format.html? && params['commit'].blank?
       params['q'] = {:local_eq => '1'}
    end
  end

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
      column 'Concessioning' do |r| r.concessions_count end
      column 'Umpiring' do |r| r.umpire_count end
    end

    br

    h3 'Games'
    table_for resource.games, class: 'index_table' do
      i = 0
      column '' do |r| i += 1 end
      column :visiting_team
      column :home_team
      column :field
      column :starts_at
      column 'H Concessions' do |g| editable_select(g, :home_team_concessions_1_id, concessionable_players_admin_team_path(g.home_team), (g.home_team_concessions_1.name rescue '')) if g.home_team == resource end
      column 'H Concessions' do |g| editable_select(g, :home_team_concessions_2_id, concessionable_players_admin_team_path(g.home_team), (g.home_team_concessions_2.name rescue '')) if g.home_team == resource end
      column 'V Concessions' do |g| editable_select(g, :visiting_team_concessions_1_id, concessionable_players_admin_team_path(g.visiting_team), (g.visiting_team_concessions_1.name rescue '')) if g.visiting_team == resource end
      column 'V Concessions' do |g| editable_select(g, :visiting_team_concessions_2_id, concessionable_players_admin_team_path(g.visiting_team), (g.visiting_team_concessions_2.name rescue '')) if g.visiting_team == resource end
      column 'Plate Ump' do |g| editable_select(g, :home_plate_umpire_id, concessionable_players_admin_team_path(g.home_team), (g.home_plate_umpire.name rescue '')) if g.home_team == resource end
      column 'Base Ump' do |g| editable_select(g, :base_umpire_id, concessionable_players_admin_team_path(g.home_team), (g.base_umpire.name rescue '')) if g.home_team == resource end
    end
  end

  filter :division
  filter :local
end
