# frozen_string_literal: true

FactoryBot.define do
  factory :pull_request do
    number { 1 }
    title { 'openになっているPR' }
    state { 'open' }
    reviewers { [12_345_678] } # Aliceのuid
  end

  factory :pull_request2, class: 'PullRequest' do
    number { 2 }
    title { 'closeされたPR' }
    state { 'closed' }
    reviewers { [12_345_678] } # Aliceのuid
  end
end
