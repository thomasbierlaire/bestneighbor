class ListesController < ApplicationController

  before_action :select_listes_dispo, only: [:index]
  before_action :select_listes_prises, only: [:index]
  before_action :select_user_liste, only: [:new]
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
    @ma_liste = @liste_user
  end

  def create
    @liste = Liste.new(liste_params)
    @liste.user = current_user
    @liste.takenby = 0
    if @liste.save
      redirect_to choix_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @liste.update(liste_params)
      redirect_to choix_path
    else
      render :edit
    end
  end

  def takenby
    if @liste.takenby != current_user.id
      @liste.takenby = current_user.id
    else
      @liste.takenby = 0
    end
    @liste.save

    ######### set up a client to talk to the Twilio REST API
    #@client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
    #@client.account.messages.create({
    #  :from => ENV["notel"], #n° Twilio
    #  :to => '+336xxxxxxxx',   #n° du destinataire
    #  :body => 'Message to send',
    #})
    #################""

    redirect_to listes_path
  end

  def destroy
    @liste.destroy
    redirect_to choix_path
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

  def select_listes_dispo
    code_postal = current_user.code_postal
    puts code_postal
    #@listes_dispo = Liste.where('user_id != ? AND takenby = ?', current_user.id, 0)
    # on sélectionne les listess qui n'appartiennent pas au current_user,
    # qui ne sont pas déjà prises et dont le propriétaire a le même code postal
    # que le current_user
    @listes_dispo = Liste.find_by_sql("SELECT l.* FROM listes l, users u WHERE
      l.user_id = u.id AND l.user_id <> '#{current_user.id}' AND l.takenby = 0 AND
      u.code_postal='#{current_user.code_postal}'")

  end

  def select_user_liste
    @liste_user = Liste.where(user_id: current_user)
  end

  def select_listes_prises
    @listes_prises = Liste.where(takenby: current_user)
  end

end
