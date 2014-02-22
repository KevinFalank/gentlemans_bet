require 'spec_helper'

describe Reminder do

  it "should find challenges that expire tomorrow" do
    challenge1 = Challenge.new(end_date: Date.new(2014,2,22))
    challenge2 = Challenge.new(end_date: Date.new(2014,2,27))
    challenge3 = Challenge.new(end_date: Date.new(2014,2,22))

    expect(Reminder.expiring_bets).to eq([challenge1, challenge3])
  end


  it "should select the users that are participating in the challenges that expire tomorrow" do
    challenge1 = Challenge.new(challenger_id: 2, 
                                  challengee_id: 1, 
                                  end_date: Date.new(2014,2,22))
    challenge2 = Challenge.new(challenger_id: 3, 
                                  challengee_id: 4, 
                                  end_date: Date.new(2014,2,27))
    expect(Reminder.send_to).to eq([1, 2])
  end

end