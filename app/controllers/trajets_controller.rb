class TrajetsController < ApplicationController

  include TrajetsHelper

  before_action :find_trajet, only: [:show, :edit, :update, :destroy, :takenby]

  def index
    @trajets = Trajet

    #Trajets pris par le current_user
    @trajets = @trajets.taken_by(current_user.id) if params[:taken_by]

    #Trajets disponibles
    @trajets = @trajets.not_taken(current_user.id, current_user.code_postal) if params[:not_taken]

    #Pagination des trajets
    @trajets = @trajets.page params[:page]
  end

  def show
    @id = params[:id]
  end

  def new
    @trajet = Trajet.new
    @mon_trajet = current_user.trajets.first
    if @mon_trajet
      @takenby = @mon_trajet.takenby
      if @takenby != 0
        @email = User.find(@takenby).email
      end
    end
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

  def destroy
    @trajet.destroy
    redirect_to choix_path
  end

  def takenby
    @user = @trajet.user

    if @trajet.takenby != current_user.id
      @trajet.takenby = current_user.id
      @cas = 1
    else
      @trajet.takenby = 0
      @cas = 0
    end

    if @trajet.save

      if @cas == 0
        # Envoi d'un mail au current_user et au propriétaire du trajet
        # pour indiquer qu'il n'est plus pris en charge
        no_trajet_taken(@user, @trajet, current_user)
        dont_take_trajet(current_user, @trajet, @user)
      end

      if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire du trajet
        # pour indiquer qu'ilest pris en charge
        trajet_taken(@user, @trajet, current_user)
        take_trajet(current_user, @trajet, @user)
      end

      redirect_to choix_path

    end
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def trajet_params
    params.require(:trajet).permit(:destination, :date, :nbpass)
  end

  def find_trajet
    @trajet = Trajet.find(params[:id])
  end

end

