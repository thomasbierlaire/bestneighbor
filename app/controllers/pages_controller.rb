class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :contact, :aide, :home, :cgu ]
  def home

  end
  def aide

  end
  def contact

  end
  def choix

  end
  def cgu

  end
  def creerliste

  end
  def prendreliste

  end
  def creertrajet

  end
  def prendretrajet

  end
end
