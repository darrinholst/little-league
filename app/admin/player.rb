ActiveAdmin.register Player do
  index do |t|
    column 'First', :first_name, sortable: 'first_name' do |resource|
      editable_text_column resource, :first_name
    end
    column 'Last', :last_name
    column :birthdate do |resource|
      resource.birthdate.strftime('%m/%d/%Y') rescue ''
    end
    column :age, sortable: 'birthdate'
    column :parents
    column 'Phone', :phone_number
    column 'Alternate Phone', :alternate_phone_number
    column 'Shirt', :shirt_size
    column :division
    column :team
    default_actions
  end

  filter :division
  filter :team
  filter :first_name
  filter :last_name
end
