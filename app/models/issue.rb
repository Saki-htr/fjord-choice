# frozen_string_literal: true

class Issue < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :point, presence: true
  validates :assignees, length: { minimum: 0 } # 空配列がきた時バリデーションエラーを発生させず値として保存する

  def self.total_points(user)
    Issue.where("#{user.uid} = ANY(assignees)").sum(:point)
  end
end
