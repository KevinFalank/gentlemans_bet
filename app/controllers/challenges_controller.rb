class ChallengesController < ApplicationController
  def new
    # render text: session.to_json # we have username/twitter handle in the session[:username]
    unless session[:username]
      redirect_to sign_in_path
    end
    @challenge = Challenge.new
  end

  def create
    user = User.find_by(username: session[:username])
    challenge = Challenge.new(params[:challenge].permit(:title, :terms, :reward, :end_date, :challengee_handle))
    challenge.challenger_id = user.id
    challenge.save
    user.client.update("#{challenge.challengee_handle} #{challenge.terms}. Your reward, #{challenge.reward}") # to add bit.ly link: #{challenge.bitly_url}
    redirect_to challenge_path(challenge)
  end

  def show
    challenge = Challenge.find(params[:id])
    render text: challenge.to_json
  end

end
