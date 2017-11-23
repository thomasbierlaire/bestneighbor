class AddHeureLivraisonToListes < ActiveRecord::Migration[5.1]
  def change
    add_column :listes, :heure_livraison, :string
  end
end
