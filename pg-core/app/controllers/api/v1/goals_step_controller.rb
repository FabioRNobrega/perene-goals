# frozen_string_literal: true
require 'goals'

module Api
  module V1
    class GoalsStepController < ApplicationController
      include Paginable

      before_action :authenticate_api_user!

      # rubocop:disable Metrics/AbcSize
      def create # rubocop:disable Metrics/MethodLength
        @goals = Goals.find(params[:goals_id])
        @goal_step =  GoalsStep.new(allowed_params_create)
        @goal_step.goals_id = @goals[:id]

        if @goal_step.save
          render(json: { message: 'Goals create with success' }, status: 201)
        else
          render(json: @goal.errors, status: :unprocessable_entity)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def show
        @goal_step = GoalsStep.find(params[:id])
        render json: @goal_step
      end

      def update
        @goal_step = GoalsStep.find(params[:id])
        if @goal_step.update(allowed_params_update)
          render(json: { message: 'Goal Step updated with success' }, status: 200)
        else
          render json: @goal_step.errors, status: :unprocessable_entity
        end
      end

      def index
        @goals_steps = GoalsStep.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @goals_steps, meta: meta_attributes(@goals_steps), adapter: :json
      end

      def delete
        @goal_step = GoalsStep.find(params[:id])
        if @goal_step.destroy
          render(json: { message: 'Goal step deleted successfully' }, status: 200)
        else
          render(json: { error: 'Failed to delete goal' }, status: :unprocessable_entity)
        end
      end

      def allowed_params_create # rubocop:disable  Metrics/MethodLength
        params.require(:goals_step).permit(
          :title,
          :description,
          :minimal_time_to_achieve,
          :time_to_reach_in_days,
          :time_to_reach_in_hours,
          :time_to_reach_in_minutes
        )
      end

      def allowed_params_update # rubocop:disable  Metrics/MethodLength
        params.require(:goals_step).permit(
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
