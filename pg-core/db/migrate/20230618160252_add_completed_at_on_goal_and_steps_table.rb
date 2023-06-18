class AddCompletedAtOnGoalAndStepsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :goals, :completed, :boolean, default: false
    add_column :goals, :completed_at, :datetime
    add_column :goals_steps, :completed, :boolean, default: false
    add_column :goals_steps, :completed_at, :datetime
  end
end
