class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :minimal_time_to_achieve
      t.integer :time_to_reach_in_days
      t.integer :time_to_reach_in_hours
      t.integer :time_to_reach_in_minutes
      t.belongs_to :goals_list

      t.timestamps
    end
  end
end
