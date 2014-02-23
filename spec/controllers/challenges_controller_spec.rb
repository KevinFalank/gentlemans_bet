require 'spec_helper'

describe ChallengesController, :type => :controller do
  describe "#index" do
    it "A user cannot navigate here without signing-in." do 
      user = User.create(username: "Charlie")
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      get :index, user_id: user.id
      expect(response).to redirect_to(:root)
    end

    it "A user cannot navigate to another user's challenges page" do 
      user1 = User.create(username: "Charlie")
      user2 = User.create(username: "John") 
      ApplicationController.any_instance.stub(:current_user).and_return(user1)
      session[:user_id] = user1.id
      get :index, user_id: user2.id
      expect(response.status).to eq(401)
    end

    it "Signed-in users can go to their challenges page." do
      user = User.create(username: "Charlie")
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      session[:user_id] = user.id
      get :index, user_id: user.id
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "a successful post creates a new challenge" do
      user = User.create(username: "Charlie")
      user.stub(:tweet).and_return("whatever")
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      expect{post :create, user_id: user.id, challenge: {'title' => 'Test Challenge', 'terms' => '@blahblah', 'end_date' => Time.now.midnight, 'reward' => 'whatever', 
          'challengee_id' => 1}, user:{'username' => 'charlie'}}.to change(Challenge, :count).by(1)
    end
  end

  describe "#show" do
    it "the user is taken to a specific challenge's page" do
      user = User.create(username: "Charlie")
      session[:user_id] = user.id
      challenge = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user.id, end_date: Time.now.midnight, reward: "A brilliant wizard's hat")
      get :show, id: challenge.id
      expect(response.status).to eq(200)
    end
  end

  describe "#update" do
    it "the challengee's response is recorded in the challenge" do
      user = User.create(username: "Charlie")
      user2 = User.create(username: "John")
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      challenge = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user2.id, status_id: 1, end_date: Time.now.midnight, reward: "A brilliant wizard's hat")
      put :update, id: challenge.id, status_id: 2
      expect(Challenge.find(challenge.id).status_id).to eq(2)
    end
  end
end