class AddNbdisposToCovoiturages < ActiveRecord::Migration[5.1]
  def change
    add_column :covoiturages, :nbdispos, :integer
  end
end
