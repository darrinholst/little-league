ActiveAdmin.register Division do
  config.filters = false
  config.sort_order = '!!!!GRRRR, I WILL JUST HANDLE IT MYSELF. GOOD FUCKING GOD!!!!'

  controller do
    def scoped_collection
      Division.order('sort_order desc')
    end
  end

  index do
    column :name
    default_actions
  end
end
