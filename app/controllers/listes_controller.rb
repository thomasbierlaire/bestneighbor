class ListesController < ApplicationController

  before_action :find_liste, only: [:show, :edit, :update, :destroy, :takenby]

  def index

    @listes = Liste

    #Listes prises par le current_user
    @listes = @listes.taken_by(current_user.id) if params[:taken_by]

    #Listes disponibles
    @listes = @listes.not_taken(current_user.id, current_user.code_postal) if params[:not_taken]

    #Pagination de la liste
    @listes = @listes.page params[:page]
  end

  def show
    @id = params[:id]
  end

  def new
    @liste = Liste.new
    @ma_liste = current_user.listes.first
    if @ma_liste
      @takenby = @ma_liste.takenby
      if @takenby != 0
        @email = User.find(@takenby).email
      end
    end
  end

  def create
    @liste = Liste.new(liste_params)
    @liste.user = current_user
    @liste.takenby = 0
    if @liste.save
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @liste.update(liste_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    @liste.destroy
    redirect_to courses_path
  end

  def takenby

    @user = @liste.user

    if @liste.takenby != current_user.id
      @liste.takenby = current_user.id
      @cas = 1
    else
      @liste.takenby = 0
      @cas = 0
    end

    if @liste.save

      if @cas == 0
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle n'est plus prise en charge
        UserMailer.no_list_taken_email(@user, @liste, current_user).deliver_later
        UserMailer.dont_take_list_email(current_user, @liste, @user).deliver_later
      end

      if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle est prise en charge
        UserMailer.list_taken_email(@user, @liste, current_user).deliver_later
        UserMailer.take_list_email(current_user, @liste, @user).deliver_later
      end

      redirect_to courses_path

    end

  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :content, :date_livraison)
  end

  def find_liste
    @liste = Liste.find(params[:id])
  end

end
