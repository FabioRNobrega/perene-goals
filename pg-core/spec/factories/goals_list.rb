# frozen_string_literal: true

FactoryBot.define do
  factory :goals_list do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    is_public { false }
    user
    
    factory :invalid_goals_list do
      title { nil }
    end
  end

end
