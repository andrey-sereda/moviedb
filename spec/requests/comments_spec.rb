require "rails_helper"

describe "Comments requests", type: :request do
  let!(:movies) {create_list(:movie, 5)}
  let!(:user) {create(:user)}

  describe "comments list" do
    it "displays right title" do
      visit "/movies/#{movies.sample.id}"
      expect(page).to have_selector("p", text: "There are no comments yet")
    end
  end

  describe "comments form" do
    it "does not show form for non-logged-in user" do
      visit "/movies/#{movies.sample.id}"
      expect(page).not_to have_selector("input[type=submit][value='Comment']")
    end

    it "shows form for logged-in user" do
      login(user)

      visit "/movies/#{movies.sample.id}"
      expect(page).to have_selector("input[type=submit][value='Comment']")
    end

    it "allows to add one comment per movie" do
      login(user)

      visit "/movies/#{movies.sample.id}"
      comment_text = Faker::Lorem.sentence
      fill_in('comment_content', with: comment_text)
      click_button('Comment')
      expect(page).to have_selector("div", text: comment_text)
      expect(page).to have_selector("div", text: user.name)

      comment_text = Faker::Lorem.sentence
      fill_in('comment_content', with: comment_text)
      click_button('Comment')
      expect(page).not_to have_selector("div", text: comment_text)
    end

    it "allows deleting the comment" do
      comment = FactoryBot.create(:comment)

      login(comment.user, password: 'password')
      visit "/movies/#{comment.movie_id}"

      remove_link = page.find(:css, "a[href='/comments/#{comment.id}']")
      remove_link.click

      expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
