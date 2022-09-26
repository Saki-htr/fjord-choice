# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequest, type: :model do
  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(build(:pull_request)).to be_valid
    end

    it 'numberが無ければ、レコード作成が無効であること' do
      pull = build(:pull_request, number: nil)
      pull.valid?
      expect(pull.errors[:number]).to include("can't be blank")
    end

    it '重複したnumberが存在するなら、レコード作成が無効であること' do
      create(:pull_request)
      pull = build(:pull_request)
      pull.valid?
      expect(pull.errors[:number]).to include('has already been taken')
    end

    it 'titleが無ければ、レコード作成が無効であること' do
      pull = build(:pull_request, title: nil)
      pull.valid?
      expect(pull.errors[:title]).to include("can't be blank")
    end

    it 'stateが無ければ、レコード作成が無効であること' do
      pull = build(:pull_request, state: nil)
      pull.valid?
      expect(pull.errors[:state]).to include("can't be blank")
    end

    it 'reviewersが無ければ、レコード作成が無効であること' do
      pull = build(:pull_request, reviewers: nil)
      pull.valid?
      expect(pull.errors[:reviewers]).to include("is too short (minimum is 0 characters)")
    end

    it 'reviewersに空配列が渡されたとき、空配列を値として保存すること' do
      pull = build(:pull_request, reviewers: [])
      expect(pull).to be_valid
      expect(pull.reviewers).to eq []
    end
  end

  describe '#review_requested' do
    it 'ユーザーがレビュワーになっているかつopenな状態のプルリクエストを返すこと' do
      user = create(:user)
      pull = create(:pull_request, reviewers: [user.uid])
      expect(described_class.review_requested(user)).to include(pull)
    end

    it 'ユーザーがレビュワーになっているが、ステータスがcloseのプルリクエストは返さないこと' do
      user = create(:user)
      pull = create(:pull_request2, reviewers: [user.uid])
      expect(described_class.review_requested(user)).not_to include(pull)
    end
  end
end
