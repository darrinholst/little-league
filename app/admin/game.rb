ActiveAdmin.register Game do
  permit_params :visiting_team_id, :home_team_id, :field_id, :starts_at, :home_team_concessions_1_id, :home_team_concessions_2_id, :visiting_team_concessions_1_id, :visiting_team_concessions_2_id, :home_plate_umpire_id, :base_umpire_id
  actions :index, :new, :create, :update, :edit, :destroy

  # allows us to initially use the multiple column sort order below
  # https://github.com/gregbell/active_admin/blob/bc791b3e3cf8084e4d9644650cbc7570b97a801a/lib/active_admin/resource_controller/data_access.rb#L220
  config.sort_order = '!'

  controller do
    def scoped_collection
      Game.includes([:field, {:home_team => [:division]}, :visiting_team]).order('starts_at, divisions.sort_order').references(:team)
    end
  end

  index do
    selectable_column
    column :visiting_team
    column :home_team
    column :field do |r| r.field.name end
    column :starts_at do |g| g.starts_at.strftime("%b %e %l:%M %p") end
    column 'H Concessions' do |g| editable_select(g, :home_team_concessions_1_id, concessionable_players_admin_team_path(g.home_team), (g.home_team_concessions_1.name rescue '')) end
    column 'V Concessions' do |g| editable_select(g, :visiting_team_concessions_1_id, concessionable_players_admin_team_path(g.visiting_team), (g.visiting_team_concessions_1.name rescue '')) end
    column 'Base Ump' do |g| editable_select(g, :base_umpire_id, concessionable_players_admin_team_path(g.home_team), (g.base_umpire.name rescue '')) end
    actions
  end

  filter :home_team_division_id, as: :select, collection: Division.all, label: 'Division'
  filter :visiting_team_id_or_home_team_id, as: :select, collection: Team.includes(:division).local.order('divisions.sort_order desc, teams.name'), label: 'Team'
  filter :home_team_local, as: :boolean, label: 'In Perry?'

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :visiting_team, :as => :select, :collection => option_groups_from_collection_for_select(Division.all, :teams, :name, :id, :name, f.object.visiting_team_id)
      f.input :home_team, :as => :select, :collection => option_groups_from_collection_for_select(Division.all, :teams, :name, :id, :name, f.object.home_team_id)
      f.input :field
      f.input :starts_at, as: :string, input_html: {value: f.object.starts_at_form}
      f.input :home_team_concessions_1, label: 'Home Concessions 1', collection: f.object.home_team.concessionable_players if f.object.home_team
      f.input :home_team_concessions_2, label: 'Home Concessions 2', collection: f.object.home_team.concessionable_players if f.object.home_team
      f.input :visiting_team_concessions_1, label: 'Visitors Concessions 1', collection: f.object.visiting_team.concessionable_players if f.object.visiting_team
      f.input :visiting_team_concessions_2, label: 'Visitors Concessions 2', collection: f.object.visiting_team.concessionable_players if f.object.visiting_team
      f.input :home_plate_umpire, label: 'Home Plate', collection: f.object.home_team.concessionable_players if f.object.home_team
      f.input :base_umpire, label: 'Base', collection: f.object.home_team.concessionable_players if f.object.home_team
    end

    f.actions
  end

  csv do
    column('Time') {|g| g.starts_at}
    column('Division') {|g| g.home_team.division.name}
    column('Field') {|g| g.field.name}
    column('Visiting Team') {|g| g.visiting_team.name}
    column('Home Team') {|g| g.home_team.name}
    column('Home Concessions') {|g| g.home_team_concessions_1.name rescue ''}
    column('Home Concessions') {|g| g.home_team_concessions_2.name rescue ''}
    column('Visiting Concessions') {|g| g.visiting_team_concessions_1.name rescue ''}
    column('Visiting Concessions') {|g| g.visiting_team_concessions_2.name rescue ''}
    column('Home Plate') {|g| g.home_plate_umpire.name rescue ''}
    column('Base') {|g| g.base_umpire.name rescue ''}
  end
end
