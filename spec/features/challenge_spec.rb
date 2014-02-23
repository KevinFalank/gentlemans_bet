require 'spec_helper'

feature 'User creating and viewing a challenge' do

  let(:user) {User.create(username: "Charlie")}
  let(:status) {Status.create(condition: "Pending")}
  let(:challenge){Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user.id, status_id: status.id, end_date: "01-01-2016", reward: "A brilliant wizard's hat")}

  before(:each) do
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    page.set_rack_session(:user_id => user.id)
  end

  context "on user_challenges#index" do
    it "sees a form for creating a challenge" do
      user.stub(:tweet).and_return("whatever")
      visit user_challenges_url(user)
      expect(page).to have_selector("form")
    end

    it "can create a new challenge" do
      user.stub(:tweet).and_return("whatever")
      visit user_challenges_url(user)

     expect {
       fill_in 'challenge_title',   with: "Hello world!"
       fill_in 'challenge_terms', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
       fill_in 'challenge_reward', with: "Blah Blah"
       fill_in 'challenge_end_date', with: "2014-02-21"
       click_button "Send Challenge"
     }.to change(Challenge, :count).by(1)
    end

    it "lists the user's challenges on the user#index" do
      challenge
      visit user_challenges_url(user)
      expect(page).to have_content("A manly bet")
    end
  end

  context "on challenges#show" do
    it "sees the terms of a challenge" do
      visit challenge_url(challenge)
      expect(page).to have_content("He who wins shall get to wear a big great grin")
    end

    it "can accept the challenge" do
      visit challenge_url(challenge)
      expect(page).to have_selector(:link_or_button, 'Sir (or Lady), I do declare that I shall meet those terms.')
    end

    it "can reject the challenge" do
      visit challenge_url(challenge)
      expect(page).to have_selector(:link_or_button, 'Your wager is beneath me.')
    end

    it "does not show the buttons if it is not the challengee" do
      user2 = User.create(username: "John")
      challenge = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin",
                      challenger_id: user.id, challengee_id: user2.id, status_id: status.id, end_date: "01-01-2016", reward: "A brilliant wizard's hat")
      visit challenge_url(challenge)
      expect(page).to have_no_selector("form")
    end

    it "shows the concede button if the challenge has been accepted" do
      status = Status.create(condition: "Accepted")
      challenge = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin",
                      challenger_id: user.id, challengee_id: user.id, status_id: status.id, end_date: "01-01-2016", reward: "A brilliant wizard's hat")
      visit challenge_url(challenge)
      expect(page).to have_selector(:link_or_button, 'Concede')
    end
  end
end
