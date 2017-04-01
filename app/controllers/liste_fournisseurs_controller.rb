class ListeFournisseursController < ApplicationController

  def index
    @liste_fournisseurs = ListeFournisseur.all
  end

   def show
    @id = params[:id]
    @liste_fournisseur = ListeFournisseur.find(params[:id])
  end

  def new

  end

  def create

  end

  def destroy

  end

end
