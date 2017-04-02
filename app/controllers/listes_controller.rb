class ListesController < ApplicationController

  def index
    @listes = Liste.all
  end

  def show
    @id = params[:id]
    @liste = Liste.find(params[:id])
  end

  def new
    @liste = Liste.new
  end

  def create
    @liste = Liste.new(liste_params)
    if @liste.save
      redirect_to new_article_path
    else
      render :new
    end
  end

  def edit
    @liste = Liste.find(params[:id])
  end

  def update
    @liste = Liste.find(params[:id])
    if @liste.update(liste_params)
      redirect_to listes_path
    else
      render :edit
    end
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :user_id)
  end

end
