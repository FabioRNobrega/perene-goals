# frozen_string_literal: true

FactoryBot.define do
    factory :goals_step do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.paragraph(sentence_count: 5) }
      minimal_time_to_achieve { Faker::Number.between(from: 1, to: 30) }
      time_to_reach_in_days { Faker::Number.between(from: 1, to: 30) }
      time_to_reach_in_hours { Faker::Number.between(from: 1, to: 24) }
      time_to_reach_in_minutes { Faker::Number.between(from: 1, to: 60) }
      goals
  
      trait :started do
        started { true }
        start_at { Time.now }
      end
  
      trait :completed do
        completed { true }
        completed_at { Time.now }
      end

      factory :invalid_goals_step do
        title { nil }
      end
    end
  end
  