class UsersController < ApplicationController

  # Connexion utilisateur existant
  def login

  end

  def check
    @current_user = User.where(nom: params[:nom], passwd: params[:passwd]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:info] = "Bienvenue #{@current_user.nom} !"
      redirect_to choix_path
    else
      session[:user_id] = nil
      flash[:info] = "Echec de la connexion"
      redirect_to users_login_path
    end
  end

  # Enregistrement nouvel utilisateur
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_login_path
    else
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    flash[:info] = "Vous êtes maintenant déconnecté."
    redirect_to root_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def user_params
    params.require(:user).permit(:nom, :prenom, :email, :notel, :passwd)
  end

end
