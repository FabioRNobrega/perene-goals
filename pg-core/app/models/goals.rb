# frozen_string_literal: true

class Goals < ActiveRecord::Base
  include Sortable

  validates_presence_of :title, :description

  def self.sort_by
    %w[title created_at]
  end

  private_class_method :sort_by

  belongs_to :goals_list
  has_many :goals_step,  class_name: 'GoalsStep', dependent: :destroy
end
