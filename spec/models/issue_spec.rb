# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(build(:issue)).to be_valid
    end

    it 'numberが無ければ、レコード作成が無効であること' do
      issue = build(:issue, number: nil)
      issue.valid?
      expect(issue.errors[:number]).to include("can't be blank")
    end

    it '重複したnumberが存在するなら、レコード作成が無効であること' do
      create(:issue)
      issue = build(:issue)
      issue.valid?
      expect(issue.errors[:number]).to include('has already been taken')
    end

    it 'pointが無ければ、レコード作成が無効であること' do
      issue = build(:issue, point: nil)
      issue.valid?
      expect(issue.errors[:point]).to include("can't be blank")
    end

    it 'assigneesが無ければ、レコード作成が無効であること' do
      issue = build(:issue, assignee_uids: nil)
      issue.valid?
      expect(issue.errors[:assignee_uids]).to include('is too short (minimum is 0 characters)')
    end

    it 'assigneesに空配列が渡されたとき、空配列を値として保存すること' do
      issue = build(:issue, assignee_uids: [])
      expect(issue).to be_valid
      expect(issue.assignee_uids).to eq []
    end
  end

  describe '#total_points' do
    it 'ユーザーにアサインされたissueの合計pointを返すこと' do
      user = create(:user)
      create(:issue, assignee_uids: [user.uid])
      create(:issue2, assignee_uids: [user.uid])
      expect(described_class.total_points(user)).to eq 3
    end
  end
end
