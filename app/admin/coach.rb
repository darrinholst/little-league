ActiveAdmin.register Coach do
  permit_params :first_name, :last_name, :phone_number, :email_address, :division_id, :team_id, :head
  actions :index, :new, :create, :update, :edit, :destroy

  # allows us to initially use the multiple column sort order below
  # https://github.com/gregbell/active_admin/blob/bc791b3e3cf8084e4d9644650cbc7570b97a801a/lib/active_admin/resource_controller/data_access.rb#L220
  config.sort_order = '!'

  controller do
    def scoped_collection
      Coach.includes(:team, :division).order('divisions.sort_order desc, teams.name asc, head desc')
    end
  end

  index do
    column 'Division' , :division      , sortable: 'divisions.sort_order' do |r| r.division_name end
    column 'Team'     , :team          , sortable: 'teams.name'
    column ''         , :head          , sortable: false                  do |r| r.head? ? '*' : '' end
    column 'First'    , :first_name    , sortable: 'first_name'           do |r| editable_text_column(r, :first_name) end
    column 'Last'     , :last_name     , sortable: 'last_name'            do |r| editable_text_column(r, :last_name) end
    column 'Email'    , :email_address , sortable: 'email_address'        do |r| editable_text_column(r, :email_address) end
    column 'Phone'    , :phone_number  , sortable: 'phone_number'         do |r| editable_text_column(r, :phone_number) end
    actions
  end

  filter :division
  filter :team

  form do |f|
    f.inputs do
      f.input :team, :as => :select, :collection => option_groups_from_collection_for_select(Division.all, :teams, :name, :id, :name, f.object.team.try(:id))
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :email_address
      f.input :head
    end

    f.actions
  end
end
