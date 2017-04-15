class TrajetsController < ApplicationController
  before_action :select_trajets_dispo, only: [:index]
  before_action :select_trajets_pris, only: [:index]
  before_action :select_user_trajet, only: [:new]
  before_action :find_trajet, only: [:show, :edit, :update, :destroy, :takenby]

  def index
    @trajetsd = @trajets_dispo
    @trajetsp = @trajets_pris
  end

  def show
    @id = params[:id]
  end

  def new
    @trajet = Trajet.new
    @mon_trajet = @trajet_user
  end

  def create
    @trajet = Trajet.new(trajet_params)
    @trajet.user = current_user
    @trajet.takenby = 0
    if @trajet.save
      redirect_to choix_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @trajet.update(trajet_params)
      redirect_to choix_path
    else
      render :edit
    end
  end

  def takenby
    if @trajet.takenby != current_user.id
      @trajet.takenby = current_user.id
    else
      @trajet.takenby = 0
    end
    @trajet.save
    redirect_to trajets_path
  end

  def destroy
    @trajet.destroy
    redirect_to choix_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def trajet_params
    params.require(:trajet).permit(:destination, :date, :heure, :nbpass)
  end

  def find_trajet
    @trajet = Trajet.find(params[:id])
  end

  def select_trajets_dispo
    @trajets_dispo = Trajet.where('user_id != ? AND takenby = ?', current_user,'0')
  end

  def select_user_trajet
    @trajet_user = Trajet.where(user_id: current_user)
  end

  def select_trajets_pris
    @trajets_pris = Trajet.where(takenby: current_user)
  end
end
