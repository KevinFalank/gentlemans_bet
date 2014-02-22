require 'spec_helper'

describe TwittersController, :type => :controller do
  describe "#auth" do
    it "redirects to a signed-in user's challenge page upon receiving a access token" do
      access_token = double("OAuth::AccessToken")
      access_token.stub(:token).and_return("token")
      access_token.stub(:secret).and_return("secret")
      access_token.stub(:params).and_return({:screen_name => "Name"})
      OAuth::RequestToken.any_instance.stub(:get_access_token).and_return(access_token)
      user = User.create(username: "charlie")
      User.stub(:find_or_create_by).and_return(user)
      post :auth
      expect(response).to redirect_to(user_challenges_url(user))
    end
  end
end