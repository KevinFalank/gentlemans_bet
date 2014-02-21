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
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      expect{post :create, user_id: user.id, challenge: {'title' => 'Test Challenge'}}.to change(Challenge, :count).by(1)
    end
  end
end