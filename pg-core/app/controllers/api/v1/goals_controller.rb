# frozen_string_literal: true
require 'goals_list'

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
        render json: @goal, include: [:goals_step]
      end

      def update
        @goal = Goals.find(params[:id])
        if @goal.update(allowed_params_update)
          render(json: { message: 'Goal updated with success' }, status: 200)
        else
          render json: @goal.errors, status: :unprocessable_entity
        end
      end

      def index
        @goals = Goals.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @goals, meta: meta_attributes(@goals), adapter: :json
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
