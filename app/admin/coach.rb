ActiveAdmin.register Coach do
  permit_params :first_name, :last_name, :phone_number, :email_address, :division_id, :team_id, :head, :address, :city, :state, :zip
  actions :index, :new, :create, :update, :edit, :destroy

  # allows us to initially use the multiple column sort order below
  # https://github.com/gregbell/active_admin/blob/bc791b3e3cf8084e4d9644650cbc7570b97a801a/lib/active_admin/resource_controller/data_access.rb#L220
  config.sort_order = '!'

  controller do
    def scoped_collection
      Coach.includes(:team, :division).order('divisions.sort_order desc, teams.name asc, head desc')
    end
  end

  csv do
    column('League ID') {'1150330'}
    column('Division') {|c| c.division.number if c.division}
    column('Team Name') {|c| c.team.name if c.team}
    column('Role') {|c| 'C'}
    column('First Name') {|c| c.first_name}
    column('Last Name') {|c| c.last_name}
    column('Address Line 1') {|c| c.address}
    column('Address Line 2') {''}
    column('City') {|c| c.city}
    column('State') {|c| c.state}
    column('Zip') {|c| c.zip}
    column('Country') {'US'}
    column('Birthdate') {''}
    column('Non-Player Email') {''}
    column('Non-Player Phone') {''}
    column('Parent 1 First Name') {''}
    column('Parent 1 Last Name') {''}
    column('Parent 1 Email') {''}
    column('Parent 1 Phone,') {''}
    column('Parent 2 First Name') {''}
    column('Parent 2 Last Name') {''}
    column('Parent 2 Email') {''}
    column('Parent 2 Phone') {''}
  end

  index do
    selectable_column
    column 'Division' , :division      , sortable: 'divisions.sort_order' do |r| r.division_name end
    column 'Team'     , :team          , sortable: 'teams.name'
    column ''         , :head          , sortable: false                  do |r| r.head? ? '*' : '' end
    column 'First'    , :first_name    , sortable: 'first_name'           do |r| editable_text_column(r, :first_name) end
    column 'Last'     , :last_name     , sortable: 'last_name'            do |r| editable_text_column(r, :last_name) end
    column 'Email'    , :email_address , sortable: 'email_address'        do |r| editable_text_column(r, :email_address) end
    column 'Phone'    , :phone_number  , sortable: 'phone_number'         do |r| editable_text_column(r, :phone_number) end
    column 'Address', :address do |r| editable_text_column(r, :address) end
    column 'City', :city do |r| editable_text_column(r, :city) end
    column 'State', :state do |r| editable_text_column(r, :state) end
    column 'Zip', :state do |r| editable_text_column(r, :zip) end
    actions
  end

  filter :division
  filter :team

  form do |f|
    f.inputs do
      f.input :team, :as => :select, :collection => option_groups_from_collection_for_select(Division.all, :teams, :name, :id, :name, f.object.team.try(:id))
      f.input :first_name
      f.input :last_name
      f.input :email_address
      f.input :phone_number
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
      f.input :head
    end

    f.actions
  end
end
