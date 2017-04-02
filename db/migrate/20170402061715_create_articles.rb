class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :nom
      t.float :prix
      t.integer :quantite
      t.integer :liste_id

      t.timestamps
    end
    add_index :articles, :liste_id
  end
end
