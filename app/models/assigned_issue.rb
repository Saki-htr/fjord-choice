# frozen_string_literal: true

class Issue < ApplicationRecord

  class << self
    def total_points(user)
      AssignedIssue.where("#{user.uid} = ANY(assignees)").sum(:point)
    end

  end
end
