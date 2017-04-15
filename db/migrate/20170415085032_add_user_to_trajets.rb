class AddUserToTrajets < ActiveRecord::Migration[5.0]
  def change
    add_reference :trajets, :user, foreign_key: true
  end
end
