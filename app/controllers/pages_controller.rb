class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :aide, :home, :cgu ]
  def home

  end
  def aide

  end
  def choix

  end
  def courses

  end
  def covoit

  end
  def cgu

  end

end
