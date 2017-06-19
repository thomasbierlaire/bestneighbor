class TrajetsController < ApplicationController
  before_action :select_trajets_dispo, only: [:index]
  before_action :select_trajets_pris, only: [:index]
  before_action :select_user_trajet, only: [:new]
  before_action :find_trajet, only: [:show, :edit, :update, :destroy]
  before_action :find_trajet_and_prop, only: [:takenby]

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
    @takenby = @takenby_user
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
      @cas = 1
    else
      @trajet.takenby = 0
      @cas = 0
    end

    if @trajet.save

      if @cas == 0
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle n'est plus prise en charge
        no_trajet_taken(@user, @trajet, current_user)
        dont_take_trajet(current_user, @trajet, @user)
      end

      if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle est prise en charge
        trajet_taken(@user, @trajet, current_user)
        take_trajet(current_user, @trajet, @user)
      end

      redirect_to trajets_path
    end
  end

  def destroy
    @trajet.destroy
    redirect_to choix_path
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

  def find_trajet_and_prop
    @trajet = Trajet.find(params[:id])

    # on récupère le propriétaire du trajet
    @user = User.find_by_sql("SELECT u.* FROM trajets t, users u WHERE
      t.id = '#{@trajet.id}' AND u.id = t.user_id")

  end

  def select_trajets_dispo
    #@trajets_dispo = Trajet.where('user_id != ? AND takenby = ?', current_user.id, 0)
    # on sélectionne les trajets qui n'appartiennent pas au current_user,
    # qui ne sont pas déjà pris et dont le propriétaire a le même code postal
    # que le current_user
    @day = Time.now
    @jour = @day.strftime("%Y") + @day.strftime("%m") + @day.strftime("%d")
    @trajets_dispo = Trajet.find_by_sql("SELECT t.* FROM trajets t, users u WHERE
      t.user_id = u.id AND t.user_id <> '#{current_user.id}' AND t.takenby = 0 AND
      u.code_postal='#{current_user.code_postal}' AND t.date >= '#{@jour}'
      order by t.date")
  end

  def select_user_trajet

    # on récupère le trajet du user courant
    @trajet_user = Trajet.where(user_id: current_user)

    # on récupère le user qui a pris en charge le trajet du user courant
    @trajet_user.each do |trajet|
      @takenby_user = User.find_by_sql("SELECT u.* FROM trajets t, users u WHERE
      t.id = '#{trajet.id}' AND u.id = t.takenby")
    end
  end

  def select_trajets_pris
    @trajets_pris = Trajet.where(takenby: current_user).order(:date)
  end

  ########################"
# Gestion de l'envoi des mails
# Certainement "crad" ...
  def dont_take_trajet(current, trajet, user)
      @current = current
      @trajet = trajet
      @user = user

      @cemail = @current.email
      @nom = @trajet.destination
      @uemail = @user[0].email

      @body = 'Bonjour ' + @cemail + ', ' + 'vous ne prenez plus en charge le trajet ' + @nom + ' de ' + @uemail

      email_sendgrid(@cemail, "Bestneighbor - vous ne prenez plus en charge un trajet", @body)
  end

  def no_trajet_taken(user, trajet, current)
    @user = user
    @trajet = trajet
    @current = current

    @uemail = @user[0].email
    @nom = @trajet.destination
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre trajet ' + @nom + " n'est plus pris en charge" + ' par ' + @cemail

    email_sendgrid(@uemail, "Bestneighbor- votre trajet n'est plus pris en charge", @body)
  end

  def take_trajet(current, trajet, user)
    @current = current
    @trajet = trajet
    @user = user

    @cemail = @current.email
    @nom = @trajet.destination
    @uemail = @user[0].email

    @body = 'Bonjour ' + @cemail + ', ' + 'vous avez pris en charge le trajet ' + @nom + ' de ' + @uemail

    email_sendgrid(@cemail, "Bestneighbor - vous prenez un trajet en charge", @body)
  end

  def trajet_taken(user, trajet, current)
    @user = user
    @trajet = trajet
    @current = current

    @uemail = @user[0].email
    @nom = @trajet.destination
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre trajet ' + @nom + ' est pris en charge par ' + @cemail + ' !'

    email_sendgrid(@uemail, "Bestneighbor - votre trajet est pris en charge", @body)
  end

end

