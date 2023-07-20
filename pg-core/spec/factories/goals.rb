# goals.rb
FactoryBot.define do
  factory :goals do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    minimal_time_to_achieve { 1 }
    time_to_reach_in_days { nil }
    time_to_reach_in_hours { nil }
    time_to_reach_in_minutes { nil }
    goals_list

    transient do
      with_step { false }
    end

    after(:create) do |goal, evaluator|
      if evaluator.with_step
        create(:goals_step, goals: goal)
      end
    end

    factory :goal_with_step do
      with_step { true }
    end

    factory :started_goal do
      started { true }
      start_at { Time.now }
    end

    factory :completed_goal do
      started { true }
      start_at { Time.now }
      completed { true }
      completed_at { Time.now }
    end
    
    factory :invalid_goals do
      title { nil }
    end
  end
end
