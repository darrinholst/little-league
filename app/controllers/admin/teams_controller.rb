class Admin::TeamsController < AdminController
  inherit_resources

  def create
    create!{ admin_teams_url }
  end

  protected

  def collection
    @divisions = Division.includes(:teams)
  end
end
