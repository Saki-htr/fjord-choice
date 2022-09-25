# frozen_string_literal: true

class Issue < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  with_options presence: true do
    validates :point
    validates :assignees
  end
  validates :reviewers, empty_array_check: true

  def self.total_points(user)
    Issue.where("#{user.uid} = ANY(assignees)").sum(:point)
  end
end
