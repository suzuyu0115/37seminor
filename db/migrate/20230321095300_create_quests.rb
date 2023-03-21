class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :title
      t.datetime :date_time
      t.string :place
      t.text :body
      t.integer :step
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
