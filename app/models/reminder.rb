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

  def self.remind #this is the method we will call in our rake task
    puts "You have been reminded" #temporary test
    #include one last method that will send the actual tweet 
    #containing the url from the challenge (search for challenge
    #by id...key in hash is the challenge id)
    #tweeted @ the users' twitter handle (search for user by id...
    #user id's are the value in the hash)
    Reminder.recipients.each do |user|
      tweet = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.oauth_token = ENV['OAUTH_TOKEN']
        config.oauth_token_secret = ENV['OAUTH_SECRET']
      end

      tweet.update(message)
    end
  end

end