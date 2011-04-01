class Admin::TeamsController < AdminController
  def index
    @divisions = Division.includes(:teams).all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      redirect_to(admin_team_url(@team), :notice => 'Team was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to(admin_team_url(@team), :notice => 'Team was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
