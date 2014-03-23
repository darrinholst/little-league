ActiveAdmin.register Player do
  actions :index, :new, :create, :update, :edit, :destroy

  config.sort_order = '!!!!GRRRR, I WILL JUST HANDLE IT MYSELF. GOOD FUCKING GOD!!!!'

  controller do
    def scoped_collection
      Player.includes(:division, :team).order('birthdate desc')
    end
  end

  index do |t|
    column 'First', :first_name, sortable: 'first_name' do |r| editable_text_column(r, :first_name) end
    column 'Last', :last_name, sortable: 'last_name' do |r| editable_text_column(r, :last_name) end
    column :birthdate do |r| r.birthdate.strftime('%m/%d/%Y') rescue '' end
    column :age, sortable: 'birthdate'
    column :parents do |r| editable_text_column(r, :parents) end
    column 'Phone', :phone_number do |r| editable_text_column(r, :phone_number) end
    column 'Alternate Phone', :alternate_phone_number do |r| editable_text_column(r, :alternate_phone_number) end
    column 'Shirt', :shirt_size do |r| editable_text_column(r, :shirt_size) end
    column :division, sortable: 'divisions.sort_order' do |r| r.division.name end
    column :team
    default_actions
  end

  filter :division
  filter :team
  filter :first_name
  filter :last_name
end
