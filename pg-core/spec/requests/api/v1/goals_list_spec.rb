# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/goals-list', type: :request do
  let(:user) { create(:user) }
  let(:goals_list) { create(:goals_list, user: user) }
  let(:valid_attributes) { attributes_for(:goals_list, user: user) }
  let(:invalid_attributes) { attributes_for(:invalid_goals_list, user: user) }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /show' do
    context 'with valid parameters' do
      it 'renders a successful response' do
        get "/api/goals-list/#{goals_list.id}",
            headers: valid_headers,
            as: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key('id')
        expect(json_response['id']).to eq(goals_list.id)

        expect(json_response).to have_key('user_id')
        expect(json_response['user_id']).to eq(user.id)

        expect(json_response).to have_key('goals')
        expect(json_response['goals']).to eq([])
      end
    end

    context 'with invalid parameters' do
      it 'renders a not found response' do
        get '/api/goals-list/123',
            headers: valid_headers,
            as: :json

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with user not logged in' do
      let(:goals_list) { create(:goals_list, user: user) }

      it 'renders an unauthorized response' do
        get "/api/goals-list/#{goals_list.id}",
            headers: {},
            as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new goals_list' do
        expect do
          post '/api/goals-list',
               params: { goals_list: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(GoalsList, :count).by(1)

        created_goals_list = GoalsList.last
        expect(created_goals_list.title).to eq(valid_attributes[:title])
      end

      it 'renders a JSON response with the new goals_list' do
        post '/api/goals-list',
             params: { goals_list: valid_attributes },
             headers: valid_headers,
             as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new goals_list' do
        expect do
          post '/api/goals-list',
               params: { goals_list: invalid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(GoalsList, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals_list' do
        post '/api/goals-list',
             params: { goals_list: invalid_attributes },
             headers: valid_headers,
             as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'does not create a new goals_list' do
        expect do
          post '/api/goals-list',
               params: { goals_list: valid_attributes },
               headers: {},
               as: :json
        end.to change(GoalsList, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals_list' do
        post '/api/goals-list',
             params: { goals_list: valid_attributes },
             headers: {},
             as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates a goals_list' do
        goal_list = GoalsList.find_by(id: goals_list.id)
        expect(goal_list.title).to eq(goals_list.title)

        patch "/api/goals-list/#{goals_list.id}",
              params: { title: 'Some new Title' },
              headers: valid_headers,
              as: :json

        goals_list_updated = GoalsList.find_by(id: goals_list.id)

        expect(goals_list_updated.title).to eq('Some new Title')
      end

      it 'renders a JSON response with the updated goals_list' do
        patch "/api/goals-list/#{goals_list.id}",
              params: { title: 'Some new Title' },
              headers: valid_headers,
              as: :json

        expect(response).to have_http_status(:success)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors' do
        patch "/api/goals-list/#{goals_list.id}",
              params: invalid_attributes,
              headers: valid_headers,
              as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'renders an unauthorized response' do
        patch "/api/goals-list/#{goals_list.id}",
              params: { goals_list: { title: 'Some new Title' } },
              headers: {},
              as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /delete' do
    let(:goals_list) { create(:goals_list, user: user) }

    context 'with valid parameters' do
      it 'deletes a goals_list' do
        expect do
          delete "/api/goals-list/#{goals_list.id}",
                 headers: valid_headers,
                 as: :json
        end.to change(GoalsList, :count).by(0)
      end

      it 'renders a JSON response with success' do
        delete "/api/goals-list/#{goals_list.id}",
               headers: valid_headers,
               as: :json

        expect(response).to have_http_status(:success)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with not found' do
        delete '/api/goals-list/123',
               headers: valid_headers,
               as: :json

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'renders an unauthorized response' do
        delete "/api/goals-list/#{goals_list.id}",
               headers: {},
               as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
