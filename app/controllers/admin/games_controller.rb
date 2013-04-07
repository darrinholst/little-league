class Admin::GamesController < AdminController
  inherit_resources
  actions :all, :except => :show

  protected

  def collection
    @games ||= end_of_association_chain.order(:starts_at).includes([{:home_team => :division}, :visiting_team, :field])
    @games = @games.where("divisions.id" => params[:division]) unless params[:division].blank?
  end
end
