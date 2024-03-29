# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  User.create!(
    name: 'garammasala29',
    provider: 'github',
    uid: 69_446_373,
    image_url: 'https://avatars.githubusercontent.com/u/69446373?v=4'
  )
  User.create!(
    name: 'yocajii',
    provider: 'github',
    uid: 33_394_676,
    image_url: 'https://avatars.githubusercontent.com/u/33394676?v=4'
  )
  User.create!(
    name: '名前がとてもとても長いユーザー',
    provider: 'github',
    uid: 99_999_999,
    image_url: 'https://avatars.githubusercontent.com/u/9876542?v=4'
  )
  9.times do |n|
    User.create!(
      name: "テスト太郎#{n + 1}",
      provider: 'github',
      uid: 1_111_111_111 + n,
      image_url: "https://avatars.githubusercontent.com/u/#{9_999_999_999 + n}?v=4"
    )
  end
  Issue.create!(
    point: 1,
    number: 1,
    assignee_uids: [58_052_292]
  )
  Issue.create!(
    point: 1,
    number: 2,
    assignee_uids: [69_446_373]
  )
  Issue.create!(
    point: 3,
    number: 4,
    assignee_uids: [58_052_292]
  )
  PullRequest.create!(
    title: '私は今単にこのお話院というもののために帰ったます。もし今に煩悶家も無論その誤認ですたまでの信ずるてい',
    number: 1,
    state: 'open',
    reviewer_uids: [69_446_373]
  )
  PullRequest.create!(
    title: '未完了の提出物一覧を担当メンターで絞り込めるようにした',
    number: 2,
    state: 'open',
    reviewer_uids: [69_446_373]
  )
  PullRequest.create!(
    title: '管理者の場合、ユーザー情報変更ページでコース変更できるようにした',
    number: 3,
    state: 'open',
    reviewer_uids: [33_394_676]
  )
  PullRequest.create!(
    title: 'マージされたPR',
    number: 4,
    state: 'closed',
    reviewer_uids: [69_446_373]
  )
  PullRequest.create!(
    title: '管理者画面のボタンを変更した',
    number: 5,
    state: 'open',
    reviewer_uids: [69_446_373]
  )
end
