ActiveAdmin.register Division do
  config.per_page = 200

  index do
    column :name
    default_actions
  end
end
