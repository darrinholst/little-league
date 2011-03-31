class Admin::PlayersController < AdminController
  def index
    @players = Player.includes(:team, :division).order(:last_name).all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      redirect_to(admin_players_url, :notice => 'Player was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html {redirect_to(admin_players_url, :notice => 'Player was successfully updated.')}
        format.json {head :ok}
      else
        format.html {render :action => "edit"}
        format.json {head :bad_request}
      end
    end
  end

  def destroy
    Player.destroy(params[:id])
    redirect_to(admin_players_url)
  end
end
