class CovoituragesController < ApplicationController

  before_action :find_covoiturage, only: [:show, :edit, :update, :destroy, :takenby]

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
    #@mon_cov = current_user.covoiturages.first
    #if @mon_cov
    #  @takenby = @mon_cov.takenby1
    #  if (@takenby != 0 and @takenby != nil)
    #    @email = User.find(@takenby).email
    #  end
    #end
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
      redirect_to covoit_path
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
        @cov.save
      elsif @cas2
        (@cov.nbpass2 === nil) ? (@cov.nbpass2 = 1) : (@cov.nbpass2 = @cov.nbpass2)
        @cov.nbdispos = @cov.nbdispos - @cov.nbpass2
        @cas = 2
        @cov.save
      elsif @cas3
        (@cov.nbpass3 === nil) ? (@cov.nbpass3 = 1) : (@cov.nbpass3 = @cov.nbpass3)
        @cov.nbdispos = @cov.nbdispos - @cov.nbpass3
        @cas = 3
        @cov.save
      end

      UserMailer.covoiturage_taken_email(@user, @cov, current_user, @cas).deliver_later
      UserMailer.take_covoiturage_email(current_user, @cov, @user, @cas).deliver_later

#########################################################
# TEST
#      @phonenumber = "+33630809785"
#      @message = "Votre proposition de trajet du #{@cov.date.to_date.strftime("%d %b %Y")} pour #{@cov.destination} est réservée par #{current_user.email}"
#      send_sms(@phonenumber, @message)

############################################################

      redirect_to covoit_path
    else
      render :edit
    end
  end

  def destroy

    @user = @cov.user

    UserMailer.covoiturage_destroyed_email(current_user, @cov).deliver_later

    if @cov.takenby1 != 0
      @takenby1 = User.find(@cov.takenby1)
      UserMailer.nomore_covoiturage_email(@takenby1, @cov, @user).deliver_later
    end
    if @cov.takenby2 != 0
      @takenby2 = User.find(@cov.takenby2)
      UserMailer.nomore_covoiturage_email(@takenby2, @cov, @user).deliver_later
    end
    if @cov.takenby3 != 0
      @takenby3 = User.find(@cov.takenby3)
      UserMailer.nomore_covoiturage_email(@takenby3, @cov, @user).deliver_later
    end

    @cov.destroy
    redirect_to covoit_path
  end

  def takenby

    @user = @cov.user
    @cas = 0

    if @cov.takenby1 === current_user.id
      @cov.takenby1 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass1
      @cov.nbpass1 = 0
      @cas = 1
    elsif @cov.takenby2 === current_user.id
      @cov.takenby2 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass2
      @cov.nbpass2 = 0
      @cas = 2
    elsif @cov.takenby3 === current_user.id
      @cov.takenby3 = 0
      @cov.nbdispos = @cov.nbdispos + @cov.nbpass3
      @cov.nbpass3 = 0
      @cas = 3
    end

    if @cov.save

      UserMailer.no_covoiturage_taken_email(@user, @cov, current_user, @cas).deliver_later
      UserMailer.dont_take_covoiturage_email(current_user, @cov, @user, @cas).deliver_later

      #if @cas == 0
        # Envoi d'un mail au current_user et au propriétaire du trajet
        # pour indiquer qu'il n'est plus pris en charge
        #UserMailer.no_trajet_taken_email(@user, @trajet, current_user).deliver_later
        #UserMailer.dont_take_trajet_email(current_user, @trajet, @user).deliver_later
      #end

      #if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire du trajet proposé
        # pour indiquer que le current_user s'est inscrit
        #UserMailer.covoiturage_taken_email(@user, @cov, current_user).deliver_later
        #UserMailer.take_covoiturage_email(current_user, @cov, @user).deliver_later
      #end

      redirect_to covoit_path

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

  def send_sms(phonenumber, message)
    uri = URI.parse("https://api.smspartner.fr/v1/send")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({
      "apiKey" => "7059942ad5244ef71e98d0107f21d1153f9946bf",
      "phoneNumbers" => "#{phonenumber}",
      "message" => "#{message}",
      "sender" => "BNeighbor",
      "gamme" => "2"
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts "RESPONSE CODE" + response.code
    puts "RESPONSE BODY" + response.body
  end

end
