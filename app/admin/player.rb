ActiveAdmin.register Player do
  actions :index, :new, :create, :update, :edit, :destroy

  config.sort_order = '!'

  controller do
    def scoped_collection
      Player.includes(:division, :team).order('birthdate desc')
    end
  end

  index do |t|
    i = 0
    column '' do |r| i += 1 end
    column 'First', :first_name, sortable: 'first_name' do |r| editable_text_column(r, :first_name) end
    column 'Last', :last_name, sortable: 'last_name' do |r| editable_text_column(r, :last_name) end
    column :birthdate do |r| editable_text_column(r, :birthdate, r.birthdate_display) end
    column :age, sortable: 'birthdate'
    column :parents do |r| editable_text_column(r, :parents) end
    column 'Phone', :phone_number do |r| editable_text_column(r, :phone_number) end
    column 'Alternate Phone', :alternate_phone_number do |r| editable_text_column(r, :alternate_phone_number) end
    column 'Shirt', :shirt_size do |r| editable_text_column(r, :shirt_size) end
    column :division, sortable: 'divisions.sort_order'
    column :team
    default_actions
  end

  filter :division
  filter :team
  filter :first_name
  filter :last_name

  form do |f|
    f.inputs do
      f.input :division
      f.input :team
      f.input :first_name
      f.input :last_name
      f.input :birthdate, as: 'string'
      f.input :parents
      f.input :phone_number
      f.input :alternate_phone_number
      f.input :shirt_size
    end

    f.actions
  end
end
