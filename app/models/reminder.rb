class Reminder

  def self.expiring_bets
    Challenge.where(end_date: (Date.today + 1))
  end

  def self.send_to
  	recipients = []
  	Reminder.expiring_bets.each do |bet|
  		recipients << bet.challenger_id
      recipients << bet.challengee_id
  	end
    recipients
  end

end