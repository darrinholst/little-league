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
    column :visiting_team
    column :home_team
    column :field do |r| r.field.name end
    column :starts_at
    default_actions
  end

  filter :visiting_team
  filter :home_team
  filter :field
  filter :home_team_local, as: :boolean, label: 'In Perry?'

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :visiting_team
      f.input :home_team
      f.input :field
      f.input :starts_at, as: :string
      f.input :home_team_concessions_1, label: 'Home Concessions 1', collection: f.object.home_team.concessionable_players
      f.input :home_team_concessions_2, label: 'Home Concessions 2', collection: f.object.home_team.concessionable_players
      f.input :visiting_team_concessions_1, label: 'Visitors Concessions 1', collection: f.object.visiting_team.concessionable_players
      f.input :visiting_team_concessions_2, label: 'Visitors Concessions 2', collection: f.object.visiting_team.concessionable_players
      f.input :home_plate_umpire, label: 'Home Plate', collection: f.object.home_team.concessionable_players
      f.input :base_umpire, label: 'Base', collection: f.object.home_team.concessionable_players
    end

    f.actions
  end

  csv do
    column('Time') {|g| g.starts_at_display}
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
