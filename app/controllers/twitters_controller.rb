class TwittersController < ApplicationController

	def index

	end

	def create
		redirect_to request_token.authorize_url
	end

	def auth
		# the `request_token` method is defined in `app/helpers/oauth.rb`
	  
	  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
	  
	  # puts @access_token.inspect
	  # our request token is only valid until we use it to get an access token, so let's delete it from our session
	  session.delete(:request_token)


	  # at this point in the code is where you'll need to create your user account and store the access token
  	user = User.find_or_create_by(username: @access_token.params[:screen_name])
  	user.access_token = @access_token.token
  	user.access_secret = @access_token.secret
		user.save
  		
  	session[:user_id] = user.id



  	# redirect to landing page
  	#redirect_to user_challenges_path

	end

	def sign_out
		session.clear
  	render 'index'
	end
end
