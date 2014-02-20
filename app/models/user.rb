class User < ActiveRecord::Base
	has_many :challenges_created, class_name: "Challenge", foreign_key: "challenger_id"
	has_many :challenges_received, class_name: "Challenge", foreign_key: "challengee_id"
	has_many :challenges_won, class_name: "Challenge", foreign_key: "winner_id"

	def add_2
		return 5
	end
end
