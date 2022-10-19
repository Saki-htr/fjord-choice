# frozen_string_literal: true

class Issue < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :point, presence: true
  # 空配列がきた時バリデーションエラーを発生させず値として保存する
  validates :assignee_uids, length: { minimum: 0 }

  def self.total_points(user)
    Issue.where("#{user.uid} = ANY(assignee_uids)").sum(:point)
  end
end
