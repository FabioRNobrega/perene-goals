# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/goals-step', type: :request do
  let(:user) { create(:user) }
  let(:goals_list) { create(:goals_list, user: user) }
  let(:goals) { create(:goals, goals_list: goals_list) }
  let(:goals_step) { create(:goals_step, goals: goals) }

  let(:valid_attributes) { attributes_for(:goals_step, goals: goals) }
  let(:invalid_attributes) { attributes_for(:invalid_goals_step, goals: goals) }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new goals step' do
        expect do
          post "/api/goals/#{goals.id}/steps",
               params: valid_attributes,
               headers: valid_headers,
               as: :json
        end.to change(GoalsStep, :count).by(1)

        created_goals_step = GoalsStep.last
        expect(created_goals_step.title).to eq(valid_attributes[:title])
      end

      it 'renders a JSON response with the new goals step' do
        post "/api/goals/#{goals.id}/steps",
             params: valid_attributes,
             headers: valid_headers,
             as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new goals step' do
        expect do
          post "/api/goals/#{goals.id}/steps",
               params: invalid_attributes,
               headers: valid_headers,
               as: :json
        end.to change(GoalsStep, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals step' do
        post "/api/goals/#{goals.id}/steps",
             params: invalid_attributes,
             headers: valid_headers,
             as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'does not create a new goals step' do
        expect do
          post "/api/goals/#{goals.id}/steps",
               params: valid_attributes,
               headers: {},
               as: :json
        end.to change(GoalsStep, :count).by(0)
      end

      it 'renders a JSON response with errors for the new goals step' do
        post "/api/goals/#{goals.id}/steps",
             params: valid_attributes,
             headers: {},
             as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates a goals step' do
        goal_step = GoalsStep.find_by(id: goals_step.id)
        expect(goal_step.title).to eq(goals_step.title)

        patch "/api/goals-step/#{goals_step.id}",
              params: { title: 'Some new Title' },
              headers: valid_headers,
              as: :json

        goal_step_updated = GoalsStep.find_by(id: goals_step.id)

        expect(goal_step_updated.title).to eq('Some new Title')
      end

      it 'renders a JSON response with the updated goals step' do
        patch "/api/goals-step/#{goals_step.id}",
              params: { title: 'Some new Title' },
              headers: valid_headers,
              as: :json

        expect(response).to have_http_status(:success)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors' do
        patch "/api/goals-step/#{goals_step.id}",
              params: invalid_attributes,
              headers: valid_headers,
              as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'renders a JSON response with errors for the update goals step' do
        patch "/api/goals-step/#{goals_step.id}",
              params: { title: 'Some new Title' },
              headers: {},
              as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /delete' do
    context 'with valid parameters' do
      it 'deletes a goals step' do
        expect do
          delete "/api/goals-step/#{goals_step.id}",
                 headers: valid_headers,
                 as: :json
        end.to change(GoalsStep, :count).by(0)
      end

      it 'renders a JSON response with success' do
        delete "/api/goals-step/#{goals_step.id}",
               headers: valid_headers,
               as: :json

        expect(response).to have_http_status(:success)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with not found' do
        delete '/api/goals-step/123',
               headers: valid_headers,
               as: :json

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with user not logged in' do
      it 'renders a JSON response with errors for delete a goals step' do
        delete "/api/goals-step/#{goals_step.id}",
               headers: {},
               as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
