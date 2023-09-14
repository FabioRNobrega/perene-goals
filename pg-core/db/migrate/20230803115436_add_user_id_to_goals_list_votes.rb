class AddUserIdToGoalsListVotes < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:goals_list_votes, :user_id)
      add_reference :goals_list_votes, :user, null: false, foreign_key: true
    end
  end
end
