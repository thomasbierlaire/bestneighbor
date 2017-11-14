class CreateCovoiturages < ActiveRecord::Migration[5.1]
  def change
    create_table :covoiturages do |t|
      t.string :destination
      t.string :date
      t.string :heure
      t.integer :nbplaces
      t.string :depart
      t.integer :takenby1
      t.integer :nbpass1
      t.integer :takenby2
      t.integer :nbpass2
      t.integer :takenby3
      t.integer :nbpass3

      t.timestamps
    end
  end
end
