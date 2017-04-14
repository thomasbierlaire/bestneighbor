class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :contact, :aide, :home ]
  def home

  end
  def aide

  end
  def contact

  end
  def choix

  end
end
