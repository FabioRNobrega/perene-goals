# frozen_string_literal: true

class GoalsStep < ActiveRecord::Base
  include Sortable

  validates_presence_of :title, :description

  def self.sort_by
    %w[title created_at]
  end

  private_class_method :sort_by

  belongs_to :goals
end
