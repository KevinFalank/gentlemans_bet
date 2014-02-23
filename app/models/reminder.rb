class Reminder

  def self.expiring_bets
    Challenge.where(end_date: (Date.today + 1))
  end

  def self.recipients
    recipients = []
  	Reminder.expiring_bets.each do |bet|
      recipients << bet.challenger_id
      recipients << bet.challengee_id
  	end
    recipients
  end

  def self.remind 
    puts "test"
    Reminder.recipients.each do |user_id|
      user = User.find(user_id)
      tweet_at = "@#{user.username}"
      tweet = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.oauth_token = ENV['OAUTH_TOKEN']
        config.oauth_token_secret = ENV['OAUTH_SECRET']
      end

      tweet.update("#{tweet_at}, you have an unresolved 
        challenge that expires tomorrow! Concede or both 
        parties shall be shamed!")
    end
  end

end