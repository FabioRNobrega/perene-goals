class AddUserIdToGoalsListVotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :goals_list_votes, :user, null: false, foreign_key: true
  end
end
