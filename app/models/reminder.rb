class Reminder

  def self.expiring_bets
    Challenge.where(end_date: (Date.today + 1))
  end

  def self.recipients
  	Reminder.expiring_bets.reduce({}) do |hash, bet|
      hash[bet.id] = [bet.challenger_id, bet.challengee_id]
      hash
  	end
  end

  def self.remind #this is the method we will call in our rake task
    puts "You have been reminded" #temporary test
    #include one last method that will send the actual tweet 
    #containing the url from the challenge (search for challenge
    #by id...key in hash is the challenge id)
    #tweeted @ the users' twitter handle (search for user by id...
    #user id's are the value in the hash)
  end

end