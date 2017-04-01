class CreateListeFournisseurs < ActiveRecord::Migration[5.0]
  def change
    create_table :liste_fournisseurs do |t|
      t.string :name
      t.integer :fournisseur_id
      t.timestamps
    end
    add_index :liste_fournisseurs, :fournisseur_id
  end
end
