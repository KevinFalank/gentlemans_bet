class User < ActiveRecord::Base
	has_many :challenges_created, class_name: "Challenge", foreign_key: "challenger_id"
	has_many :challenges_received, class_name: "Challenge", foreign_key: "challengee_id"
	has_many :challenges_won, class_name: "Challenge", foreign_key: "winner_id"

	validates :username, uniqueness: true
	
	def self.tweet (token, secret, message)
		# Twitter::REST::Client
	  Twitter.configure do |config|
	    config.oauth_token = token
	    config.oauth_token_secret = secret
	  end

	  Twitter.update(message)
	end

end
