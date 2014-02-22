class TwittersController < ApplicationController

	def new
		redirect_to request_token.authorize_url
	end

	def auth
	  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
	  session.delete(:request_token)
  	user = User.find_or_create_by(username: @access_token.params[:screen_name])
  	user.access_token = @access_token.token
  	user.access_secret = @access_token.secret
		user.save
  	session[:user_id] = user.id
    redirect_oauth(user)
	end

	def sign_out
		session.clear
  	redirect_to :root
	end

  private

  def redirect_oauth(user)
    if session[:origin]
      redirect_to session[:origin]
    else
      redirect_to user_challenges_path(user)
    end
  end
end
