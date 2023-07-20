# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoalsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/goals-list/1/goals').to route_to(
        controller: 'api/v1/goals',
        action: 'create',
        format: :json,
        goals_list_id: '1' 
      )
    end

    it 'routes to #show' do
      expect(get: '/api/goals/1/steps').to route_to(
        controller: 'api/v1/goals',
        action: 'show',
        format: :json,
        goals_id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: '/api/goals/1').to route_to(
        controller: 'api/v1/goals',
        action: 'update',
        format: :json,
        id: '1'
      )
    end

    it 'routes to #delete' do
      expect(delete: '/api/goals/1').to route_to(
        controller: 'api/v1/goals',
        action: 'delete',
        format: :json,
        id: '1'
      )
    end
  end
end
