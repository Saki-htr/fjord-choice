# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    number { 1 }
    point { 1 }
    assignee_uids { [12_345_678] } # Aliceのuid
  end

  factory :issue2, class: 'Issue' do
    number { 2 }
    point { 2 }
    assignee_uids { [12_345_678] } # Aliceのuid
  end
end
