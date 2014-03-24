ActiveAdmin.register Field do
  actions :index, :new, :create, :update, :edit, :destroy

  config.filters = false
  config.sort_order = '!'

  controller do
    def scoped_collection
      Field.order('name asc')
    end
  end

  index do
    column :name
    default_actions
  end
end
