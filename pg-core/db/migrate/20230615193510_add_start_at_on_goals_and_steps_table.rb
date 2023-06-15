class AddStartAtOnGoalsAndStepsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :goals, :started, :boolean, default: false
    add_column :goals, :start_at, :datetime
    add_column :goals_steps, :started, :boolean, default: false
    add_column :goals_steps, :start_at, :datetime
  end
end
