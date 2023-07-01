# frozen_string_literal: true

class GoalsList < ActiveRecord::Base
  include Sortable

  validates_presence_of :title, :description

  def self.sort_by
    %w[title created_at]
  end

  private_class_method :sort_by

  belongs_to :user
  has_many :goals,  class_name: 'Goals', dependent: :destroy
end
