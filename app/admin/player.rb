ActiveAdmin.register Player do
  permit_params :first_name, :last_name, :division_id, :team_id, :birthdate, :parents, :phone_number, :alternate_phone_number, :shirt_size, :concessions_exempt, :address, :city, :state, :zip
  actions :index, :new, :create, :update, :edit, :destroy

  config.sort_order = 'birthdate_desc'

  controller do
    def scoped_collection
      Player.includes(:division, :team)
    end
  end

  csv do
    column (:division) {|player| player.division.name if player.division}
    column ('Division #') {|player| player.division.number if player.division}
    column (:team) {|player| player.team.name if player.team}
    column ('Role') {|player| 'B'}
    column('First Name') {|p| p.first_name}
    column('Last Name') {|p| p.last_name}
    column('Address 1') {|p| p.address}
    column('Address 2') {''}
    column('City') {|p| p.city}
    column('State') {|p| p.state}
    column('Zip') {|p| p.zip}
    column('Country') {'US'}
    column('Birthdate') {|p| p.birthdate_display}
  end

  index do |t|
    i = 0
    column '' do |r| i += 1 end
    column 'First', :first_name, sortable: 'first_name' do |r| editable_text_column(r, :first_name) end
    column 'Last', :last_name, sortable: 'last_name' do |r| editable_text_column(r, :last_name) end
    column :birthdate do |r| editable_text_column(r, :birthdate, r.birthdate_display) end
    column :age, sortable: 'birthdate'
    column :parents do |r| editable_text_column(r, :parents) end
    column 'Phone', :phone_number do |r| editable_text_column(r, :phone_number) end
    column 'Alternate Phone', :alternate_phone_number do |r| editable_text_column(r, :alternate_phone_number) end
    column 'Address', :address do |r| editable_text_column(r, :address) end
    column 'City', :city do |r| editable_text_column(r, :city) end
    column 'State', :state do |r| editable_text_column(r, :state) end
    column 'Zip', :state do |r| editable_text_column(r, :zip) end
    column 'Shirt', :shirt_size do |r| editable_text_column(r, :shirt_size) end
    column :division, sortable: 'divisions.sort_order' do |r| editable_select(r, :division_id, admin_divisions_path, (r.division.name rescue '')) end
    column :team do |r| editable_select(r, :team_id, local_teams_admin_division_path(r.division.id), (r.team.name rescue '')) end
    actions
  end

  filter :division
  filter :team
  filter :first_name
  filter :last_name

  form do |f|
    f.inputs do
      f.input :division
      f.input :team
      f.input :first_name
      f.input :last_name
      f.input :birthdate, as: 'string'
      f.input :parents
      f.input :phone_number
      f.input :alternate_phone_number
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
      f.input :shirt_size
    end

    f.actions
  end
end
