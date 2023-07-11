# frozen_string_literal: true
require 'goals_list'
require 'goals_step'

module Api
  module V1
    class GoalsController < ApplicationController
      include Paginable

      before_action :authenticate_api_user!

      # rubocop:disable Metrics/AbcSize
      def create # rubocop:disable Metrics/MethodLength
        @goals_list = GoalsList.find(params[:goals_list_id])
        @goal =  Goals.new(allowed_params_create)
        @goal.goals_list_id = @goals_list[:id]

        if @goal.save
          render(json: @goal, status: 201)
        else
          render(json: @goal.errors, status: :unprocessable_entity)
        end
      end
      
      # rubocop:enable Metrics/AbcSize
      def show
        @goal = Goals.includes(:goals_step).find(params[:goals_id])
        @ordered_steps = @goal.goals_step.order(Arel.sql("start_at DESC NULLS LAST"))
        goal_with_ordered_steps = @goal.as_json(include: :goals_step)
        goal_with_ordered_steps["goals_step"] = @ordered_steps
        render json: goal_with_ordered_steps
      end
      

      def update
        @goal = Goals.find(params[:id])
        
        if params[:completed]
          @goals_steps = GoalsStep.where(goals_id: @goal.id)
          if @goal.started 
            @goal.update(allowed_params_update)
          else 
            updated_params = allowed_params_update.merge(started: true, start_at: Time.now)
            @goal.update(updated_params)
          end
      
          for @step in @goals_steps
            if @step.started 
              @step.update(completed: true, completed_at: Time.now)
            else
              @step.update(
                completed: true, 
                completed_at: Time.now,
                started: true,
                start_at: Time.now
              )
            end
          end
      
          render(json: { message: 'Goal and Goals Steps updated with success' }, status: 200)
        elsif @goal.update(allowed_params_update)
          render(json: { message: 'Goal updated with success' }, status: 200)
        else
          render(json: @goal.errors, status: :unprocessable_entity)
        end
      end
      

      def index
        @goals = Goals.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @goals, meta: meta_attributes(@goals), adapter: :json
      end

      def delete
        @goal = Goals.find(params[:id])
        if @goal.destroy
          render(json: { message: 'Goal deleted successfully' }, status: 200)
        else
          render(json: { error: 'Failed to delete goal' }, status: :unprocessable_entity)
        end
      end

      def allowed_params_create # rubocop:disable  Metrics/MethodLength
        params.require(:goal).permit(
          :title,
          :description,
          :minimal_time_to_achieve,
          :time_to_reach_in_days,
          :time_to_reach_in_hours,
          :time_to_reach_in_minutes
        )
      end

      def allowed_params_update # rubocop:disable  Metrics/MethodLength
        params.require(:goal).permit(
          :title,
          :description,
          :started,
          :start_at,
          :completed,
          :completed_at,
          :minimal_time_to_achieve,
          :time_to_reach_in_days,
          :time_to_reach_in_hours,
          :time_to_reach_in_minutes
        )
      end
    end
  end
end
