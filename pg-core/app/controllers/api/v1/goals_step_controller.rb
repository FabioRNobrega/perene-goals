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
        @goal =  GoalsStep.new(allowed_params_create)
        @goal.goals_id = @goals[:id]

        if @goal.save
          render(json: { message: 'Goals create with success' }, status: 201)
        else
          render(json: @goal.errors, status: :unprocessable_entity)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def show
        @goal = GoalsStep.find(params[:id])
        render json: @goal
      end

      def update
        @goal = GoalsStep.find(params[:id])
        if @goal.update(allowed_params_update)
          render(json: { message: 'goal updated with success' }, status: 201)
        else
          render json: @goal.errors, status: :unprocessable_entity
        end
      end

      def index
        @goals = GoalsStep.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @goals, meta: meta_attributes(@goals), adapter: :json
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
          :minimal_time_to_achieve,
          :time_to_reach_in_days,
          :time_to_reach_in_hours,
          :time_to_reach_in_minutes
        )
      end
    end
  end
end
