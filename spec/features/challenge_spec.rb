require 'spec_helper'

feature 'User creating a challenge' do
  context "on user_challenges#index" do
    it "sees a form for creating a challenge" do
      user = User.create(username: "Charlie")
      page.set_rack_session(:user_id => user.id)
      visit user_challenges_url(user)
      expect(current_url).to eq(user_challenges_url(user)) 
    end

    it "can create a new challenge" do
     user = User.create(username: "Charlie")
     ApplicationController.any_instance.stub(:current_user).and_return(user)
     page.set_rack_session(:user_id => user.id)
     visit user_challenges_url(user)

     expect {
       fill_in 'challenge_title',   with: "Hello world!"
       fill_in 'challenge_terms', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
       fill_in 'challenge_reward', with: "Blah Blah"
       fill_in 'challenge_end_date', with: "2014-02-21"
       click_button "Send Challenge"
     }.to change(Challenge, :count).by(1)
    end

    it "lists the user's challenges" do

    end
  end
end