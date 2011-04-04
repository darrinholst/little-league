class Admin::FieldsController < AdminController
  def index
    @fields = Field.order(:name).all
  end

  def new
    @field = Field.new
  end

  def edit
    @field = Field.find(params[:id])
  end

  def create
    @field = Field.new(params[:field])

    if @field.save
      redirect_to(admin_fields_url, :notice => 'Field was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @field = Field.find(params[:id])

    if @field.update_attributes(params[:field])
      redirect_to(admin_fields_url, :notice => 'Field was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
