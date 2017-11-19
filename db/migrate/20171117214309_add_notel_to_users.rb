class AddNotelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notel, :string
  end
end
