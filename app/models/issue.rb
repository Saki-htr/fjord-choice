# frozen_string_literal: true

class Issue < ApplicationRecord

  def self.total_points(user)
    Issue.where("#{user.uid} = ANY(assignees)").sum(:point)
  end
end
