class CreateGoalsListVotes < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?
      create_table :goals_list_votes do |t|
        t.references :goals_list, null: false, foreign_key: true
        t.integer :votes_up
        t.integer :votes_down

        t.timestamps
      end
    end
  end
end
