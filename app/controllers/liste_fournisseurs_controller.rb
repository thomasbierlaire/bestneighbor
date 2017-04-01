class ListeFournisseursController < ApplicationController

  def index
    @liste_fournisseurs = ListeFournisseur.all
  end

end
