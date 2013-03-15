class Admin::TeamsController < AdminController
  inherit_resources

  def create
    create!{ admin_teams_url }
  end

  def selection
    render :json => Team.all_local
  end

  protected

  def collection
    @divisions = Division.includes(:teams)
  end
end
