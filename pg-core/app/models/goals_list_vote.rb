# frozen_string_literal: true

class GoalsListVote < ApplicationRecord
    belongs_to :goals_list
    validates :user_id, uniqueness: { scope: :goals_list_id }
end
  