# frozen_string_literal: true

class PullRequest < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  with_options presence: true do
    validates :title
    validates :state
  end
  # 空配列がきた時バリデーションエラーを発生させず値として保存する
  validates :reviewer_uids, length: { minimum: 0 }
  enum state: {
    open: 0,
    closed: 1
  }

  def self.review_requested(user)
    PullRequest.where("#{user.uid} = ANY(reviewer_uids)").where(state: 'open')
  end
end
