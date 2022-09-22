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
      issue = build(:issue, assignees: nil)
      issue.valid?
      expect(issue.errors[:assignees]).to include("can't be blank")
    end
  end

  describe '#total_points' do
    it 'ユーザーにアサインされたissueの合計pointを返すこと' do
      user = create(:user)
      create(:issue, assignees: [user.uid]) # assigneesとuserのuidの値が同じことを明示すべきか?
      create(:issue2, assignees: [user.uid])
      expect(Issue.total_points(user)).to eq 3
    end
  end
end
