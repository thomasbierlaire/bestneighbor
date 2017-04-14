class AddUserToListes < ActiveRecord::Migration[5.0]
  def change
    add_reference :listes, :user, foreign_key: true
  end
end
