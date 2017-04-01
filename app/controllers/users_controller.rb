class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @id = params[:id]
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to users_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def user_params
    params.require(:user).permit(:name, :email, :passwd)
  end

end
