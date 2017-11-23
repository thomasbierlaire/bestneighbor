class DropForeignKeyTrajets < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :trajets, :users
  end
end
