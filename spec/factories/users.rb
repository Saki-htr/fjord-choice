# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Alice' }
    provider { 'github' }
    uid { 12_345_678 }
    image_url { 'https://example.com/image' }
  end
end
