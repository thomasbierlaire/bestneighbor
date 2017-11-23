class ChangeContentToBeTextInListes < ActiveRecord::Migration[5.1]
  def change
    change_column :listes, :content, :text
  end
end
