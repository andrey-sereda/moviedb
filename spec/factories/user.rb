FactoryBot.define do
  factory :user do
    name {"user#{Random.rand(500)}"}
    email {"#{name}@example.com"}
    confirmed_at {Time.zone.now}
    password {'password'}
  end
end