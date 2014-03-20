ActiveAdmin.register Player do
  config.per_page = 200

  index do
    column :first_name
    column :last_name
    column :birthdate
    column :age
    column :parents
    column :phone_number
    column :alternate_phone_number
    column :shirt_size
    default_actions
  end
end
