class CreateListeDemandeurs < ActiveRecord::Migration[5.0]
  def change
    create_table :liste_demandeurs do |t|
      t.string :name
      t.integer :demandeur_id
      t.timestamps
    end
    add_index :liste_demandeurs, :demandeur_id
  end
end
