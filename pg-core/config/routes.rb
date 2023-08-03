# frozen_string_literal: true

require Rails.root.join('lib', 'api_constraints')

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

      
      get 'users', to: 'user#index'
      delete 'users', to: 'user#destroy'

      # Goals List 
      get 'all-goals-list', to: 'goals_list#index_public'
      get 'my-goals-list', to: 'goals_list#index_private'
      post 'goals-list', to: 'goals_list#create'
      get 'goals-list/:id', to: 'goals_list#show'
      patch 'goals-list/:id', to: 'goals_list#update'
      delete 'goals-list/:id', to: 'goals_list#delete'
      post 'goals-list/:id/clone', to: 'goals_list#clone'
      patch 'goals-list/:id/vote', to: 'goals_list_votes#update'

      # Goals
      post 'goals-list/:goals_list_id/goals', to: 'goals#create'
      get 'goals/:goals_id/steps', to: 'goals#show'
      patch 'goals/:id', to: 'goals#update'
      delete 'goals/:id', to: 'goals#delete'

      # Goals Steps
      post 'goals/:goals_id/steps', to: 'goals_step#create'
      patch 'goals-step/:id', to: 'goals_step#update'
      delete 'goals-step/:id', to: 'goals_step#delete'
      get 'goals-step/:id', to: 'goals_step#show'

      # Learning
      post 'learning', to: 'learning#create'
      patch 'learning/:id', to: 'learning#update'
      get 'learning/:id', to: 'learning#show'
      get 'learning', to: 'learning#index'
      delete 'learning/:id', to: 'learning#delete'

      # Metrics 
      get 'metrics/goal/:id', to: 'metrics#goal_metrics'
      get 'metrics/goal-list/:id', to: 'metrics#goal_list_metrics'

    end
  end
end
