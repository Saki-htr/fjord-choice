# frozen_string_literal: true

class RawIssue < ApplicationRecord
  has_one :assigned_issue
end
