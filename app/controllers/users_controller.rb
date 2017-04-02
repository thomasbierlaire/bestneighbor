class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  # Action de visualisation
  def index
    @users = User.all
  end

  def show
  end

  # Actions de création
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to choix_path
    else
      render :new
    end
  end

  # Actions de modification
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

# Actions de suppression
  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def user_params
    params.require(:user).permit(:nom, :prenom, :email, :notel, :passwd)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
