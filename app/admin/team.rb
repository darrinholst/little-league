ActiveAdmin.register Team do
  config.per_page = 200

  index do
    column :name
    column :division
    column :local
    default_actions
  end
end
