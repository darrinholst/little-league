class Admin::FieldsController < AdminController
  inherit_resources
  actions :all, :except => :show

  protected

  def collection
    @fields ||= end_of_association_chain.order(:name)
  end
end
