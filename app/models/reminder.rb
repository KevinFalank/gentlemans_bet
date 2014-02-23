class Reminder

  def self.expiring_bets
    Challenge.where(end_date: (Date.today + 1))
  end

  def self.remind 
    tweet = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.access_token = ENV['OAUTH_TOKEN']
        config.access_token_secret = ENV['OAUTH_SECRET']
      end

    Reminder.expiring_bets.each do |challenge|
      tweet.update("@#{challenge.challenger.username}, @#{challenge.challengee.username}, you have an unresolved 
        challenge!  #{challenge.bitly_url} #gm_bet")
    end
  end
end