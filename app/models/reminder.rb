class Reminder

  def self.send_to
    Challenge.where(end_date: (Date.today + 1))
  end

end