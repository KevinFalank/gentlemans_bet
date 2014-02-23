class User < ActiveRecord::Base
	has_many :challenges_created, class_name: "Challenge", foreign_key: "challenger_id"
	has_many :challenges_received, class_name: "Challenge", foreign_key: "challengee_id"
	has_many :challenges_won, class_name: "Challenge", foreign_key: "winner_id"

	validates :username, uniqueness: true
	
	def tweet (message)

		tweet = Twitter::REST::Client.new do |config|
		  config.consumer_key = ENV['TWITTER_KEY']
		  config.consumer_secret = ENV['TWITTER_SECRET']
		  config.access_token = self.access_token
	    config.access_token_secret = self.access_secret
		end

	  tweet.update(message)
	end

end
