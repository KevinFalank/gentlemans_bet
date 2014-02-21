class TwitterController < ApplicationController

  def sign_in
    redirect_to request_token.authorize_url
  end

  def auth
    # the `request_token` method is defined in `app/helpers/oauth.rb`
      @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

      # our request token is only valid until we use it to get an access token, so let's delete it from our session
      session.delete(:request_token)

      # at this point in the code is where you'll need to create your user account and store the access token

      @user = User.find_or_create_by(username: @access_token.params[:screen_name])
      @user.update(access_token: @access_token.token, access_secret: @access_token.secret)
      @user.save
      session[:username] = @user.username

      redirect_to new_challenge_path
  end
end
