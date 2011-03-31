class Admin::CoachesController < AdminController
  def index
    @coaches = Coach.includes(:team, :division).order(:division_id, :team_id).all
  end

  def new
    @coach = Coach.new
  end

  def edit
    @coach = Coach.find(params[:id])
  end

  def create
    @coach = Coach.new(params[:coach])

    if @coach.save
      redirect_to(admin_coaches_url, :notice => 'Coach was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @coach = Coach.find(params[:id])

    if @coach.update_attributes(params[:coach])
      redirect_to(admin_coaches_url, :notice => 'Coach was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    Coach.destroy(params[:id])
    redirect_to(admin_coaches_url)
  end
end
