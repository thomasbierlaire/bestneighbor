class ListesController < ApplicationController

  def index
    @listes = Liste.all
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

  def show
    @id = params[:id]
    @liste = Liste.find(params[:id])
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :user_id)
  end

end
