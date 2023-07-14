# frozen_string_literal: true

module Api
  module V1
    class LearningController < ApplicationController
      include Paginable

      # rubocop:disable Metrics/AbcSize
      def create # rubocop:disable Metrics/MethodLength
       
        @learning =  Learning.new(allowed_params_create)

        if @learning.save
          render(json: @learning, status: 201)
        else
          render(json: @learning.errors, status: :unprocessable_entity)
        end
      end
      
      # rubocop:enable Metrics/AbcSize
      def show
        @learning = Learning.find(params[:id])

        render(json: @learning, status: 200)
      end
      

      def update
        @learning = Learning.find(params[:id])
        
        if @learning.update(allowed_params_update)
          render(json: { message: 'Learning post updated with success' }, status: 200)
        else
          render(json: @learning.errors, status: :unprocessable_entity)
        end
      end
      

      def index
        @learning = Learning.sorted(params[:sort], params[:dir])
                     .page(current_page)
                     .per(per_page)
        render json: @learning, meta: meta_attributes(@learning), adapter: :json
      end

      def delete
        @learning = @learning.find(params[:id])
        if @learning.destroy
          render(json: { message: 'Leaning post deleted successfully' }, status: 200)
        else
          render(json: { error: 'Failed to delete leaning post' }, status: :unprocessable_entity)
        end
      end

      def allowed_params_create # rubocop:disable  Metrics/MethodLength
        params.require(:learning).permit(
          :title,
          :description,
          :author,
          :image_link,
          :reference_link
        )
      end

      def allowed_params_update # rubocop:disable  Metrics/MethodLength
        params.require(:learning).permit(
          :title,
          :description,
          :author,
          :image_link,
          :reference_link
        )
      end
    end
  end
end
