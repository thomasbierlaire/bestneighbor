class ListesController < ApplicationController

  before_action :find_liste, only: [:show, :edit, :update, :destroy, :takenby]

  include SmsManagement

  def index

    @listes = Liste

    #Listes commandées par le current_user
    @listes = @listes.my_listes(current_user.id) if params[:my_listes]

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

    @user = @liste.user

    UserMailer.liste_destroyed_email(current_user, @liste).deliver_later

    @phonenumber = format_tel(current_user.notel)
    @message = "Bestneighbor - Vous avez supprimé votre liste #{@liste.nom} pour livraison le #{@liste.date_livraison.to_date.strftime("%d %b %Y")}"
    send_sms(@phonenumber, @message)

    if @liste.takenby != 0
      @takenby = User.find(@liste.takenby)
      UserMailer.nomore_liste_email(@takenby, @liste, @user).deliver_later

      @phonenumber = format_tel(@takenby.notel)
      @message = "Bestneighbor - La liste #{@liste.nom} de #{@user.email} pour livraison le #{@liste.date_livraison.to_date.strftime("%d %b %Y")} est annulée"
      send_sms(@phonenumber, @message)
    end

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
        @phonenumber = format_tel(@user.notel)
        @message = "Bestneighbor - Votre liste #{@liste.nom} n'est plus prise en charge par #{current_user.email}"
        send_sms(@phonenumber, @message)

        UserMailer.dont_take_list_email(current_user, @liste, @user).deliver_later
        @phonenumber = format_tel(current_user.notel)
        @message = "Bestneighbor - Vous ne prenez plus en charge la liste #{@liste.nom} de #{@user.email}"
        send_sms(@phonenumber, @message)
      end

      if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle est prise en charge
        UserMailer.list_taken_email(@user, @liste, current_user).deliver_later
        @phonenumber = format_tel(@user.notel)
        @message = "Bestneighbor - Votre liste #{@liste.nom} est prise en charge par #{current_user.email}"
        send_sms(@phonenumber, @message)

        UserMailer.take_list_email(current_user, @liste, @user).deliver_later
        @phonenumber = format_tel(current_user.notel)
        @message = "Bestneighbor - Vous avez pris en charge la liste #{@liste.nom} de #{@user.email}"
        send_sms(@phonenumber, @message)
      end

      redirect_to courses_path

    end

  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :content, :adresse_livraison, :date_livraison, :heure_livraison)
  end

  def find_liste
    @liste = Liste.find(params[:id])
  end

end
