class CreateDemandeurs < ActiveRecord::Migration[5.0]
  def change
    create_table :demandeurs do |t|
      t.integer :user_id
      t.timestamps
    end
    add_index :demandeurs, :user_id
  end
end
