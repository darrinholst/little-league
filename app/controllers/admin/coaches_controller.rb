class Admin::CoachesController < AdminController
  inherit_resources
  actions :all, :except => :show

  protected

  def collection
    @coaches ||= end_of_association_chain.includes(:team, :division).order('divisions.id', 'teams.name')
  end
end
