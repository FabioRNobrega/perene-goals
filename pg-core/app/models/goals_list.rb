# frozen_string_literal: true

class GoalsList < ActiveRecord::Base
  include Sortable

  validates_presence_of :title, :description

  def self.sort_by
    %w[title created_at]
  end

  def clone_for_user(new_user_id)
    new_goal_list = dup
    new_goal_list.user_id = new_user_id
    new_goal_list.is_public = false
    new_goal_list.save!

    goals.each do |original_goal|
      new_goal = original_goal.dup
      new_goal.goals_list_id = new_goal_list.id
      new_goal.save!

      original_goal.goals_step.each do |original_goal_step|
        new_goal_step = original_goal_step.dup
        new_goal_step.goals_id = new_goal.id
        new_goal_step.save!
      end
    end

    new_goal_list
  end

  def votes_count
    votes_up = goals_list_votes.sum(:votes_up)
    votes_down = goals_list_votes.sum(:votes_down)
    { votes_up: votes_up, votes_down: votes_down }
  end

  private_class_method :sort_by

  belongs_to :user
  has_many :goals,  class_name: 'Goals', dependent: :destroy
  has_many :goals_list_votes, dependent: :destroy
end
