ActiveAdmin.register Game do
  permit_params :visiting_team_id, :home_team_id, :field_id, :starts_at
  actions :index, :new, :create, :update, :edit, :destroy

  controller do
    def scoped_collection
      Game.includes(:field, :home_team, :visiting_team)
    end
  end

  index do
    column :visiting_team
    column :home_team
    column :field do |r| r.field.name end
    column :starts_at
    default_actions
  end

  filter :visiting_team
  filter :home_team
  filter :field

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :visiting_team
      f.input :home_team
      f.input :field
      f.input :starts_at, as: :string
    end

    f.actions
  end
end
