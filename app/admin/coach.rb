ActiveAdmin.register Coach do
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
