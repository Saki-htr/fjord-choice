FactoryBot.define do
  factory :issue do
    number { 1 }
    point { 1 }
    assignees { [12_345_678] } # Aliceのuid
  end

  factory :issue2, class: Issue do
    number { 2 }
    point { 2 }
    assignees { [12_345_678] } # Aliceのuid
  end
end
