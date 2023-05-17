# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      before_action :authenticate_api_user!

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        render(json: { message: 'User was delete with success' }, status: 200)
      end
    end
  end
end
