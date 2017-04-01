class ListeDemandeursController < ApplicationController

  def index
    @liste_demandeurs = ListeDemandeur.all
  end

end
