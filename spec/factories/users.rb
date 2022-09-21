FactoryBot.define do
  factory :user do
    name { 'Alice' }
    provider { 'github' }
    uid { 12345678 }
    image_url { 'https://avatars.githubusercontent.com/u/example?v=4' }
  end
end
