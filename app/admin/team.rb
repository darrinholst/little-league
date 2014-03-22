ActiveAdmin.register Team do
  index do
    column :name
    column :division
    column :local
    default_actions
  end
end
