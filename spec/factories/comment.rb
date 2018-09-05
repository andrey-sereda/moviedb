FactoryBot.define do
  factory :comment do
    content {Faker::Lorem.sentence}
    movie {Movie.all.sample || association(:movie)}
    user {User.all.sample || association(:user)}
  end
end