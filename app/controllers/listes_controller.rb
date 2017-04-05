class ListesController < ApplicationController

  before_action :select_listes_dispo, only: [:index]
  before_action :select_listes_prises, only: [:index]

  def index
    @listesd = @listes_dispo
    @listesp = @listes_prises
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

  def destroy
    @liste.destroy
    redirect_to listes_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :user_id)
  end

  def select_listes_dispo
    @listes_dispo = Liste.where("takenby = '0' and user_id != '40'")
  end


  def select_listes_prises
    @listes_prises = Liste.where("takenby = '40'")
  end

end
