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
          render(json: { message: 'Goals List create with success' }, status: 201)
        else
          render(json: @goals_list.errors, status: :unprocessable_entity)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def show
        @goals_list = GoalsList.includes(:goals).find(params[:id])
        render json: @goals_list, include: [:goals]
      end

      def update
        @goals_list = GoalsList.find(params[:id])
        if @goals_list.update(allowed_params_update)
          render(json: { message: 'goals_list updated with success' }, status: 201)
        else
          render json: @goals_list.errors, status: :unprocessable_entity
        end
      end

      def index_public
        @goals_lists = GoalsList.where(is_public: true)

        @goals_lists = @goals_lists.sorted(params[:sort], params[:dir])
                                 .page(current_page)
                                 .per(per_page)
      
        render json: @goals_lists, meta: meta_attributes(@goals_lists), adapter: :json
      end

      def index_private      
        @goals_lists = @goals_lists.sorted(params[:sort], params[:dir])
                                 .page(current_page)
                                 .per(per_page)
      
        render json: @goals_lists, meta: meta_attributes(@goals_lists), adapter: :json
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
