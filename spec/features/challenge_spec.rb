require 'spec_helper'

feature 'User creating a challenge' do
  context "on user_challenges#index" do
    it "sees a form for creating a challenge" do
      user = User.create(username: "Charlie")
      visit user_challenges_url(user)
      expect(page).to should_have("form") 
    end
  end
end