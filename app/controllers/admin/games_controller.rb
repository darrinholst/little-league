class Admin::GamesController < AdminController
  inherit_resources
  actions :all, :except => :show

  protected

  def collection
    @games ||= end_of_association_chain.order(:starts_at)
  end
end
