class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected

  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def oauth_consumer
	  raise RuntimeError, "You must set TWITTER_KEY and TWITTER_SECRET in your server environment." unless ENV['TWITTER_KEY'] and ENV['TWITTER_SECRET']
	  @consumer ||= OAuth::Consumer.new(
	    ENV['TWITTER_KEY'],
	    ENV['TWITTER_SECRET'],
	    :site => "https://api.twitter.com"
	  )
	end

	def request_token
	  if not session[:request_token]
	    # this 'host_and_port' logic allows our app to work both locally and on Heroku
	    host_and_port = request.host
	    host_and_port << ":3000" if request.host == "localhost"
	    # debugger
	    # the `oauth_consumer` method is defined above
	    session[:request_token] = oauth_consumer.get_request_token(
	      :oauth_callback => "http://#{host_and_port}/auth"
	    )
	  end
	  session[:request_token]
	end

	def current_user

	end

end
