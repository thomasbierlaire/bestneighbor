class ChangeCodePostalToBeStringInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :code_postal, :string
  end
end
