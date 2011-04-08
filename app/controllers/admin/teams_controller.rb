class Admin::TeamsController < AdminController
  inherit_resources

  protected

  def collection
    @divisions = Division.includes(:teams)
  end
end
