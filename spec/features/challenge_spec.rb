require 'spec_helper'

feature 'User creating a challenge' do
  context "on user_challenges#index" do
    it "sees a form for creating a challenge" do
      user = User.create(username: "Charlie")
      page.set_rack_session(:user_id => user.id)
      visit user_challenges_url(user)
      expect(current_url).to eq(user_challenges_url(user)) 
    end
  end
end