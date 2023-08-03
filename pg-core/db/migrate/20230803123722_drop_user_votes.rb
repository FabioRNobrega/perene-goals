class DropUserVotes < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_votes
  end
end
