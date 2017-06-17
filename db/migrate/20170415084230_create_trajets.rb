class CreateTrajets < ActiveRecord::Migration[5.0]
  def change
    create_table :trajets do |t|
      t.string :destination
      t.string :date
      t.time :heure
      t.integer :nbpass
      t.integer :takenby

      t.timestamps
    end
  end
end
