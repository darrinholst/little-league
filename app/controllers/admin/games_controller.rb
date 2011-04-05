class Admin::GamesController < AdminController
  def index
    @games = Game.order(:starts_at).all
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to(admin_games_url, :notice => 'Game was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      redirect_to(admin_games_url, :notice => 'Game was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
