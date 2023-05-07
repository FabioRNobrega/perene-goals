class CreateGoalsList < ActiveRecord::Migration[6.1]
  def change
    create_table :goals_lists do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.boolean :is_public, :default => false
      t.belongs_to :user

      t.timestamps
    end
  end
end
