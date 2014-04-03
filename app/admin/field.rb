ActiveAdmin.register Field do
  permit_params :name
  actions :index, :new, :create, :update, :edit, :destroy

  config.filters = false
  config.sort_order = 'name_asc'

  index do
    column :name
    default_actions
  end
end
