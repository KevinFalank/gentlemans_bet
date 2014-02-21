class ChallengesController < ApplicationController
  def index
    @challenge = Challenge.new
    if session[:user_id] == params[:user_id]
      @challenges_created = current_user.challenges_created
      @challenges_received = current_user.challenges_received
    elsif session[:user_id] != nil
      render :status => 401
    else
      redirect_to :root
    end
  end

  def create
    params[:challenge][:challenger_id] = current_user.id
    params[:challenge][:status_id] = 1
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to user_challenges_path(current_user)
    else
      render "index"
    end
  end

  def test_root
  end

  private

  def challenge_params
    params.required(:challenge).permit(:title, :terms, :reward, :end_date, :challenger_id, :challengee_id, :status_id)
  end
end


    