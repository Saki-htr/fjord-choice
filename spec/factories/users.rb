# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Alice' }
    provider { 'github' }
    uid { 12_345_678 }
    image_url { 'https://example.com/image' }
  end

  factory :user2, class: 'User' do
    name { 'Bob' }
    provider { 'github' }
    uid { 12_345_679 }
    image_url { 'https://example.com/image' }
  end
end
