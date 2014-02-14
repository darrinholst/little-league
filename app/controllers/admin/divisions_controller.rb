class Admin::DivisionsController < AdminController
  inherit_resources

  def selection
    render :json => Division.all
  end

  protected

  def resource
    @division ||= end_of_association_chain.includes(:players).find(params[:id])
  end
end
