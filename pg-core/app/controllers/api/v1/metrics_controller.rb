# frozen_string_literal: true
require 'goals_list'
require 'goals_step'
require 'goals'

module Api
  module V1
    class MetricsController < ApplicationController
      before_action :authenticate_api_user!

      # rubocop:enable Metrics/AbcSize
      def goal_metrics
        goal = Goals.includes(:goals_step).find(params[:id])
        total_steps = goal.goals_step.count
        completed_steps = goal.goals_step.where(completed: true).count

        render json: {total: total_steps, completed: completed_steps}
      end
      
      def goal_list_metrics
        goal_list = GoalsList.includes(:goals).find(params[:id])
        total_goals = goal_list.goals.count
        completed_goals = goal_list.goals.where(completed: true).count

        render json: {total: total_goals, completed: completed_goals}
      end
    end
  end
end
