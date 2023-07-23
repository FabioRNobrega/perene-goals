# frozen_string_literal: true

require 'goals'

module Api
  module V1
    class GoalsListController < ApplicationController
      include Paginable

      before_action :authenticate_api_user!, except: :index_public


      # rubocop:disable Metrics/AbcSize
      def create # rubocop:disable Metrics/MethodLength
        @goals_list = GoalsList.new(allowed_params_create)
        @goals_list.user_id = current_api_user[:id]

        if @goals_list.save
          render(json: @goals_list, status: 201)
        else
          render(json: @goals_list.errors, status: :unprocessable_entity)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def show
        @goals_list = GoalsList.includes(:goals).find_by(id: params[:id])
        if  @goals_list
        @ordered_goals = @goals_list.goals.order(Arel.sql("start_at DESC NULLS LAST"))
        goal_list_with_ordered_goals = @goals_list.as_json(include: :goals)
        goal_list_with_ordered_goals["goals"] = @ordered_goals
        render json: goal_list_with_ordered_goals
        else 
          render(json: { error: 'Goal List not found' }, status: :not_found)
        end
      end
      

      def update
        @goals_list = GoalsList.find_by(id: params[:id])
        if @goals_list.update(allowed_params_update)
          render(json: { message: 'goals_list updated with success' }, status: 201)
        else
          render json: @goals_list.errors, status: :unprocessable_entity
        end
      end

      def index_public
        @goals_list = GoalsList.where(is_public: true)

        @goals_list = @goals_list.sorted(params[:sort], params[:dir])
                                 .page(current_page)
                                 .per(per_page)
      
        render json: @goals_list, meta: meta_attributes(@goals_list), adapter: :json
      end

      def index_private   
        @goals_list = GoalsList.where(user_id: current_api_user[:id]) 
        @goals_list = @goals_list.sorted(params[:sort], params[:dir])
                                 .page(current_page)
                                 .per(per_page)
      
        render json: @goals_list, meta: meta_attributes(@goals_list), adapter: :json
      end


      def delete
        @goal_list = GoalsList.find_by(id: params[:id])
        if @goal_list
          @goal_list.destroy()
          render(json: { message: 'Goal list deleted successfully' }, status: 200)
        else
          render(json: { error: 'Goal list not found' }, status: :not_found)        
        end
      end


      def allowed_params_create # rubocop:disable  Metrics/MethodLength
        params.require(:goals_list).permit(
          :title,
          :description,
          :is_public
        )
      end

      def allowed_params_update # rubocop:disable  Metrics/MethodLength
        params.require(:goals_list).permit(
          :title,
          :description,
          :is_public
        )
      end
    end
  end
end
