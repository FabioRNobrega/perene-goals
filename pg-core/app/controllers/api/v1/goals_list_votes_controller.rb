module Api
  module V1
    class GoalsListVotesController < ApplicationController
      before_action :authenticate_api_user!

      def update
        @goals_list = GoalsList.find_by(id: params[:id])
        vote = @goals_list.goals_list_votes.find_by(user_id: current_api_user.id)

        if vote
          vote.update(votes_up: params[:votes_up], votes_down: params[:votes_down])
          render json: { message: 'Vote updated successfully.' }
        else
          @goals_list.goals_list_votes.create(user_id: current_api_user.id, votes_up: params[:votes_up], votes_down: params[:votes_down])
          render json: { message: 'Vote created successfully.' }
        end
      end
    end
  end
end
