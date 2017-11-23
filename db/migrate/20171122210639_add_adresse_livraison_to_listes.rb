class AddAdresseLivraisonToListes < ActiveRecord::Migration[5.1]
  def change
    add_column :listes, :adresse_livraison, :string
  end
end
