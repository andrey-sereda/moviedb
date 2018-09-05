require "rails_helper"

describe "Top Commenters requests", type: :request do
  describe "top commenters list" do
    it "displays right title" do
      visit "/top_commenters"
      expect(page).to have_selector("h1", text: "Top Weekly Commenters")
    end
  end
end
