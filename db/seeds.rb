# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Rails.env.development? || Rails.env.production?
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
  12.times do |n|
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
    assignees: [58_052_292]
  )
  Issue.create!(
    point: 1,
    number: 2,
    assignees: [69_446_373]
  )
  Issue.create!(
    point: 3,
    number: 4,
    assignees: [58_052_292]
  )
  PullRequest.create!(
    title: 'js-choices-single-selectを使っている箇所において、Railsで渡したデータの並び順がJavaScriptに渡っても保持されるようにした。',
    number: 1,
    state: 'open',
    reviewers: [69_446_373]
  )
  PullRequest.create!(
    title: '未完了の提出物一覧を担当メンターで絞り込めるようにした',
    number: 2,
    state: 'open',
    reviewers: [69_446_373]
  )
  PullRequest.create!(
    title: '管理者の場合、ユーザー情報変更ページでコース変更できるようにした',
    number: 3,
    state: 'open',
    reviewers: [33_394_676]
  )
  PullRequest.create!(
    title: 'マージされたPR',
    number: 4,
    state: 'closed',
    reviewers: [69_446_373]
  )
  PullRequest.create!(
    title: '管理者画面のボタンを変更した',
    number: 5,
    state: 'open',
    reviewers: [69_446_373]
  )
  5.times do |n|
    PullRequest.create!(
      title: "プルリクエストのタイトル#{n}",
      number: 1000 + n,
      state: 'open',
      reviewers: [1_111_111_111 + n]
    )
  end
end
