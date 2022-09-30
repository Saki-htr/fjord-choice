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
    name: 'Saki-htr',
    provider: 'github',
    uid: 58_052_292,
    image_url: 'https://avatars.githubusercontent.com/u/58052292?v=4'
  )

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
end
