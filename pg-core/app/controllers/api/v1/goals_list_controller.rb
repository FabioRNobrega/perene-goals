# frozen_string_literal: true

module Api
  module V1
    class GoalsListController < ApplicationController
      include Paginable

      before_action :authenticate_api_user!

      # rubocop:disable Metrics/AbcSize
      def create # rubocop:disable Metrics/MethodLength
        @item = GoalsList.new(allowed_params_create)
        @item.user_id = current_api_user[:id]

        if @item.save
          render(json: { message: 'Goals List create with success' }, status: 201)
        else
          render(json: @item.errors, status: :unprocessable_entity)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def show
        @item = GoalsList.find(params[:id])
        render json: @item
      end

      def update
        @item = GoalsList.find(params[:id])
        if @item.update(allowed_params_update)
          render(json: { message: 'Item updated with success' }, status: 201)
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def index
        @items = GoalsList.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @items, meta: meta_attributes(@items), adapter: :json
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
