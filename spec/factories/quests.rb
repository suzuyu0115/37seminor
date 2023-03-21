FactoryBot.define do
  factory :quest do
    title { "title" }
    body { "body" }
    place { "place" }

    trait :not_cleared do
      state { :not_cleared }
    end

    trait :cleared do
      state { :cleared }
    end
  
    trait :past do
      datetime { DateTime.now.ago(1.hours) }
      state { :cleared }
    end
  end
end
