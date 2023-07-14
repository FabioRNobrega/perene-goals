# frozen_string_literal: true

class Learning < ActiveRecord::Base
  include Sortable

  validates_presence_of :title, :description, :author

  def self.sort_by
    %w[title created_at]
  end

  private_class_method :sort_by
end
