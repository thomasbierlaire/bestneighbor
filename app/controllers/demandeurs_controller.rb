class DemandeursController < ApplicationController

  def index
    @demandeurs = Demandeur.all
  end

end
