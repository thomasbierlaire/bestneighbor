class ListesController < ApplicationController

  before_action :select_listes_dispo, only: [:index]
  before_action :select_listes_prises, only: [:index]
  before_action :find_liste, only: [:show, :edit, :update, :destroy, :takenby]

  def index
    @listesd = @listes_dispo
    @listesp = @listes_prises
  end

  def show
    @id = params[:id]
  end

  def new
    @liste = Liste.new
  end

  def create
    @liste = Liste.new(liste_params)
    @liste.user_id = @current_user.id
    @liste.takenby = 0
    if @liste.save
      redirect_to new_article_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @liste.update(liste_params)
      redirect_to listes_path
    else
      render :edit
    end
  end

  def takenby
    @liste.takenby = @current_user.id
    @liste.save
    redirect_to listes_path
  end

  def destroy
    @liste.takenby = 0
    @liste.save
    redirect_to listes_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :user_id, :takenby, :magasin, :date_livraison)
  end

  def find_liste
    @liste = Liste.find(params[:id])
  end

  def select_listes_dispo
    @listes_dispo = Liste.where('user_id != ? AND takenby = ?', @current_user.id,'0')
  end

  def select_user_liste
    @liste_user = Liste.where(user_id: @current_user.id)
  end

  def select_listes_prises
    @listes_prises = Liste.where(takenby: @current_user.id)
  end

end
