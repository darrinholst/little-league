class Admin::DivisionsController < AdminController
  def index
    @divisions = Division.all
  end

  def show
    @division = Division.includes(:players).find(params[:id])
  end

  def new
    @division = Division.new
  end

  def edit
    @division = Division.find(params[:id])
  end

  def create
    @division = Division.new(params[:division])

    if @division.save
      redirect_to(admin_division_url(@division), :notice => 'Division was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @division = Division.find(params[:id])

    if @division.update_attributes(params[:division])
      redirect_to(admin_division_url(@division), :notice => 'Division was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
