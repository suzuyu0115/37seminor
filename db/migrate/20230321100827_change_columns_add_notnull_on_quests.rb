class ChangeColumnsAddNotnullOnQuests < ActiveRecord::Migration[7.0]
  def change
    change_column_null :quests, :title, false
    change_column_null :quests, :place, false
    change_column_null :quests, :body, false
    change_column_null :quests, :step, false
  end
end
