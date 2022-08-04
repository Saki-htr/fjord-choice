# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_assigned_issues
  has_many :assigned_issue, through: :user_assigned_issues
end
