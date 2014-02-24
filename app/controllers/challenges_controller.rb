class ChallengesController < ApplicationController
  def index
    @errors = nil
    @user = User.new
    @challenge = Challenge.new
    if session[:user_id] == params[:user_id].to_i
      @challenges_created = current_user.challenges_created
      @challenges_received = current_user.challenges_received
    elsif session[:user_id] != nil
      render :status => 401
    else
      redirect_to :root
    end
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      @challenge.obtain_bitly_url(challenge_url(@challenge))
      current_user.tweet(@challenge.issue)
      redirect_to user_challenges_path(current_user)
    else
      @user = User.new(username: params[:user][:username])
      @errors = @challenge.errors.full_messages
      @challenges_created = current_user.challenges_created
      @challenges_received = current_user.challenges_received
      render "index"
    end
  end

  def show
    if session[:user_id]
      @current_user = current_user
      @challenge = Challenge.find(params[:id])
    else
      session[:origin] = request.original_url
      redirect_to "/login"
    end
  end

  def update
    challenge = Challenge.find(params[:id])
    if params[:status_id] 
      challenge.status_id = params[:status_id]
      challenge.save
      redirect_to user_challenges_path(current_user)
    else
      challenge.update_winner(current_user)
      current_user.tweet(challenge.concede)
      redirect_to user_challenges_path(current_user)
    end
  end

  private

  def challenge_params
    params[:challenge][:challenger_id] = current_user.id
    params[:challenge][:status_id] = 1
    challengee = User.find_or_create_by(username: params[:user][:username].downcase)
    params[:challenge][:challengee_id] = challengee.id
    params.required(:challenge).permit(:title, :terms, :reward, :end_date, :challenger_id, :challengee_id, :status_id)
  end
end



