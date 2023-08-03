class CreateUserVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goals_list, null: false, foreign_key: true
      t.integer :votes_up, default: 0
      t.integer :votes_down, default: 0

      t.timestamps
    end

    add_index :user_votes, [:user_id, :goals_list_id], unique: true
  end
end
