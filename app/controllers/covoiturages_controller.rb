class CovoituragesController < ApplicationController

  before_action :find_covoiturage, only: [:show, :edit, :update, :destroy, :takenby]

  include SmsManagement

  def index
    @covoiturages = Covoiturage

    #Trajets proposés par le current_user
    @covoiturages = @covoiturages.my_covoits(current_user.id) if params[:my_covoits]

    #Trajets réservés par le current_user
    @covoiturages = @covoiturages.taken_by(current_user.id) if params[:taken_by]

    #Trajets proposés disponibles
    @covoiturages = @covoiturages.not_taken(current_user.id, current_user.code_postal) if params[:not_taken]

    #Pagination des trajets
    @covoiturages = @covoiturages.page params[:page]
  end

  def show
    @id = params[:id]
  end

  def new
    @cov = Covoiturage.new
  end

  def create
    @cov = Covoiturage.new(covoiturage_params)
    @cov.user = current_user
    @cov.takenby1 = 0
    @cov.nbpass1 = 0
    @cov.takenby2 = 0
    @cov.nbpass2 = 0
    @cov.takenby3 = 0
    @cov.nbpass3 = 0
    @cov.nbdispos = @cov.nbplaces
    if @cov.save
      flash[:notice] = "Votre proposition de trajet est créée"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit

  end

  def update

    @cas1 = @cas2 = @cas3 = false
    @cas = 0

    if @cov.user != current_user
      if (@cov.takenby1 != current_user.id and @cov.takenby1 === 0)
        @cov.takenby1 = current_user.id
        @cas1 = true
      elsif (@cov.takenby2 != current_user.id and @cov.takenby2 === 0)
        @cov.takenby2 = current_user.id
        @cas2 = true
      elsif (@cov.takenby3 != current_user.id and @cov.takenby3 === 0)
        @cov.takenby3 = current_user.id
        @cas3 = true
        end
    end

    if @cov.update(covoiturage_params)

      @user = @cov.user

      if @cas1
        (@cov.nbpass1 === nil) ? (@cov.nbpass1 = 1) : (@cov.nbpass1 = @cov.nbpass1)
        @cov.nbdispos = @cov.nbdispos - @cov.nbpass1
        @cas = 1
        @smsnbpass = @cov.nbpass1
        @cov.save
      elsif @cas2
        (@cov.nbpass2 === nil) ? (@cov.nbpass2 = 1) : (@cov.nbpass2 = @cov.nbpass2)
        @cov.nbdispos = @cov.nbdispos - @cov.nbpass2
        @cas = 2
        @smsnbpass = @cov.nbpass2
        @cov.save
      elsif @cas3
        (@cov.nbpass3 === nil) ? (@cov.nbpass3 = 1) : (@cov.nbpass3 = @cov.nbpass3)
        @cov.nbdispos = @cov.nbdispos - @cov.nbpass3
        @cas = 3
        @smsnbpass = @cov.nbpass3
        @cov.save
      end


#########################################################
# Envoi mails et SMS
      UserMailer.covoiturage_taken_email(@user, @cov, current_user, @cas).deliver_later

      @phonenumber = format_tel(@user.notel)
      @message = "Bestneighbor - Votre trajet du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure} est réservé par #{current_user.email}"
      send_sms(@phonenumber, @message)

      UserMailer.take_covoiturage_email(current_user, @cov, @user, @cas).deliver_later

      @phonenumber = format_tel(current_user.notel)
      @message = "Bestneighbor - Vous avez réservé #{@smsnbpass} place(s) pour le trajet de #{@user.email} du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure}"
      send_sms(@phonenumber, @message)

############################################################

      flash[:notice] = "Votre réservation de trajet est faite"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy

    @user = @cov.user

    UserMailer.covoiturage_destroyed_email(current_user, @cov).deliver_later

    @phonenumber = format_tel(current_user.notel)
    @message = "Bestneighbor - Vous avez supprimé votre proposition de trajet du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure}"
    send_sms(@phonenumber, @message)

    if @cov.takenby1 != 0
      @takenby1 = User.find(@cov.takenby1)
      UserMailer.nomore_covoiturage_email(@takenby1, @cov, @user).deliver_later

      @phonenumber = format_tel(@takenby1.notel)
      @message = "Bestneighbor - Le trajet proposé par #{@user.email} du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure} est annulé"
      send_sms(@phonenumber, @message)
    end

    if @cov.takenby2 != 0
      @takenby2 = User.find(@cov.takenby2)
      UserMailer.nomore_covoiturage_email(@takenby2, @cov, @user).deliver_later

      @phonenumber = format_tel(@takenby2.notel)
      @message = "Bestneighbor - Le trajet proposé par #{@user.email} du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure} est annulé"
      send_sms(@phonenumber, @message)
    end

    if @cov.takenby3 != 0
      @takenby3 = User.find(@cov.takenby3)
      UserMailer.nomore_covoiturage_email(@takenby3, @cov, @user).deliver_later

      @phonenumber = format_tel(@takenby3.notel)
      @message = "Bestneighbor - Le trajet proposé par #{@user.email} du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure} est annulé"
      send_sms(@phonenumber, @message)
    end

    @cov.destroy
    flash[:notice] = "Votre proposition de trajet est supprimée"
    redirect_to root_path
  end

  def takenby

    @user = @cov.user
    @cas = 0

    if @cov.takenby1 === current_user.id
      @cov.takenby1 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass1
      @smsnbpass = @cov.nbpass1
      @cov.nbpass1 = 0
      @cas = 1
    elsif @cov.takenby2 === current_user.id
      @cov.takenby2 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass2
      @smsnbpass = @cov.nbpass2
      @cov.nbpass2 = 0
      @cas = 2
    elsif @cov.takenby3 === current_user.id
      @cov.takenby3 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass3
      @smsnbpass = @cov.nbpass3
      @cov.nbpass3 = 0
      @cas = 3
    end

    if @cov.save

#########################################################
# Envoi mails et SMS
      UserMailer.no_covoiturage_taken_email(@user, @cov, current_user, @cas).deliver_later

      @phonenumber = format_tel(@user.notel)
      @message = "Bestneighbor - Votre trajet du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure} n'est plus réservé par #{current_user.email}"
      send_sms(@phonenumber, @message)

      UserMailer.dont_take_covoiturage_email(current_user, @cov, @user, @cas).deliver_later

      @phonenumber = format_tel(current_user.notel)
      @message = "Bestneighbor - Vous avez annulé votre réservation de #{@smsnbpass} place(s) pour le trajet de #{@user.email} du #{@cov.date.to_date.strftime("%d %b %Y")} à #{@cov.heure}"
      send_sms(@phonenumber, @message)

############################################################

      flash[:notice] = "Votre réservation est annulée"
      redirect_to root_path

    end
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def covoiturage_params
    params.require(:covoiturage).permit(:destination, :date, :heure, :nbplaces, :depart, :takenby1, :nbpass1, :takenby2, :nbpass2, :takenby3, :nbpass3)
  end

  def find_covoiturage
    @cov = Covoiturage.find(params[:id])
  end

end
