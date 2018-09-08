require "rails_helper"
include RandomHelper

describe User do
  it {is_expected.to allow_value("+48 999 888 777").for(:phone_number)}
  it {is_expected.to allow_value("48 999-888-777").for(:phone_number)}
  it {is_expected.to allow_value("48 999-888-777").for(:phone_number)}
  it {is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number)}
  it {is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number)}
  it {is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number)}

  describe "top commenters query" do
    it "fetches correct data" do
      users = FactoryBot.create_list(:user, 5)
      movies = FactoryBot.create_list(:movie, 15)
      expected_result = {}

      30.times do |i|
        rand_movie = movies.sample
        rand_user = users.sample
        next if Comment.where(movie: rand_movie, user: rand_user).exists?

        rand_creation_date = rand_time(14.days.ago)
        comment = FactoryBot.create(:comment, movie: rand_movie, user: rand_user)
        comment.update_attribute(:created_at, rand_creation_date)

        if rand_creation_date > 7.days.ago
          expected_result[rand_user.id] ||= 0
          expected_result[rand_user.id] += 1
        end
      end

      result = User.top_commenters

      # check whether the result is properly sorted
      expect(result.values).to eq(result.values.sort_by {|x| -x})

      result.each do |user, comments_number|
        expect(expected_result[user.id]).to eq(comments_number)
      end
    end
  end
end
