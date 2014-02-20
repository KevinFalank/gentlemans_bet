class Challenge < ActiveRecord::Base
	belongs_to :challenger, class_name: "User", foreign_key: "challenger_id"
	belongs_to :challengee, class_name: "User", foreign_key: "challengee_id"
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	belongs_to :status

end
