class Reminder

  def self.expiring_bets
    Challenge.where(end_date: (Date.today + 1))
  end

  def self.send_to
  	# recipients = []
  	Reminder.expiring_bets.reduce({}) do |hash, bet|
      hash[bet.id] = [bet.challenger_id, bet.challengee_id]
      hash
  		# recipients << bet.challenger_id
    #   recipients << bet.challengee_id
  	end
    # recipients
  end

end