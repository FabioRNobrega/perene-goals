# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(Goals.order('created_at desc').to_sql).to eq Goals.sorted('created_at', 'desc').to_sql
      expect(Goals.order('created_at asc').to_sql).to eq Goals.sorted('created_at', 'asc').to_sql
    end
  end
end
