ActiveAdmin.register Coach do
  config.per_page = 200

  index do
    column :first_name
    column :last_name
    column :email_address
    column :head
    column :division
    column :team
    default_actions
  end
end
