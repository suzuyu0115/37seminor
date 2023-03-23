class EditSkipColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :quests, :step, :integer, default: 0, null: false
  end
end
