class CreateFournisseurs < ActiveRecord::Migration[5.0]
  def change
    create_table :fournisseurs do |t|
      t.integer :user_id
      t.timestamps
    end
    add_index :fournisseurs, :user_id
  end
end
