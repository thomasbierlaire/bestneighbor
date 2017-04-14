
class CreateListes < ActiveRecord::Migration[5.0]
  def change
    create_table :listes do |t|
      t.string :nom
      t.string :magasin
      t.date :date_livraison
      t.integer :takenby

      t.timestamps
    end

  end
end
