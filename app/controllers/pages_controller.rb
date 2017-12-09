class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :contact, :home, :cgu ]
  def home
    if user_signed_in?
      #Nb de voisins du current_user
      @neighbors = User.where(code_postal: current_user.code_postal).count - 1
    end
  end
  def contact

  end
  def courses

  end
  def covoit

  end
  def cgu

  end

end
