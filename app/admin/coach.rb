ActiveAdmin.register Coach do
  # maybe it's better with ransack rather than metasearch...doubt it
  # https://github.com/gregbell/active_admin/blob/bc791b3e3cf8084e4d9644650cbc7570b97a801a/lib/active_admin/resource_controller/data_access.rb#L220
  config.sort_order = '!!!!GRRRR, I WILL JUST HANDLE IT MYSELF. GOOD FUCKING GOD!!!!'

  controller do
    def scoped_collection
      Coach.includes(:team, :division).order('divisions.sort_order desc, teams.name asc, head desc')
    end
  end

  index do
    column 'Division' , :division      , sortable: 'divisions.sort_order' do |r| r.division.name end
    column 'Team'     , :team          , sortable: 'teams.name'
    column 'First'    , :first_name    , sortable: 'first_name'           do |r| editable_text_column(r, :first_name) end
    column 'Last'     , :last_name     , sortable: 'last_name'            do |r| editable_text_column(r, :last_name) end
    column 'Email'    , :email_address , sortable: 'email_address'        do |r| editable_text_column(r, :email_address) end
    column 'Phone'    , :phone_number  , sortable: 'phone_number'         do |r| editable_text_column(r, :phone_number) end
    column 'Head?'    , :head
    default_actions
  end

  filter :division
  filter :team
end
