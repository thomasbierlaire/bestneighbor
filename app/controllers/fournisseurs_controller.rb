class FournisseursController < ApplicationController

  def index
    @fournisseurs = Fournisseur.all
  end

end
