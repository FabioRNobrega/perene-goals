# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe '/goals', type: :request do
  let(:user) { create(:user) }
  let(:goals_list) { create(:goals_list, user: user) }
  let(:goals) { create(:goals, goals_list: goals_list) }
  let(:goals_step) {create(:goals_step, goals: goals)}

  let(:valid_attributes) { attributes_for(:goals, goals_list: goals_list) }
  let(:invalid_attributes) { attributes_for(:invalid_goals, goals_list: goals_list) }
  let(:valid_headers) { user.create_new_auth_token }


  describe 'GET /show' do
    it 'renders a successful response' do
      get "/api/goals/#{goals.id}/steps", headers: valid_headers, as: :json
      expect(response).to have_http_status(:ok)
         json_response = JSON.parse(response.body)
         
         expect(json_response).to have_key('id')
         expect(json_response['id']).to eq(goals.id)
     
         expect(json_response).to have_key('goals_list_id')
         expect(json_response['goals_list_id']).to eq(goals_list.id)

         expect(json_response).to have_key('goals_step')
         expect(json_response['goals_step']).to eq([])
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new goal' do
        expect do
          post "/api/goals-list/#{goals_list.id}/goals",
               params: valid_attributes,
               headers: valid_headers,
               as: :json
        end.to change(Goals, :count).by(1)

        created_goal = Goals.last
        expect(created_goal.title).to eq(valid_attributes[:title])
      end

      it 'renders a JSON response with the new goals' do
        post "/api/goals-list/#{goals_list.id}/goals",
             params: valid_attributes,
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new goals' do
        expect do
          post "/api/goals-list/#{goals_list.id}/goals",
               params: invalid_attributes,
               headers: valid_headers,
               as: :json
        end.to change(Goals, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals' do
        post "/api/goals-list/#{goals_list.id}/goals",
             params: invalid_attributes,
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'does not create a new goals' do
        expect do
          post "/api/goals-list/#{goals_list.id}/goals",
               params: valid_attributes,
               headers: {},
               as: :json
        end.to change(Goals, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals' do
        post "/api/goals-list/#{goals_list.id}/goals",
             params: valid_attributes,
             headers: {},
             as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
