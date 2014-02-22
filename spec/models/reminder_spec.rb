require 'spec_helper'

describe Reminder do
  # let(:challenge1){ Challenge.new(challenger_id: 1,
  #                                 challengee_id:  2,
  #                                 end_date:   Date.new(2014,2,22)) }
  # let(:challenge2){ Challenge.new(challenger_id: 3,
  #                                 challengee_id:  4,
  #                                 end_date:   Date.new(2014,2,27)) }
  # let(:challenge3){ Challenge.new(challenger_id: 5,
  #                                 challengee_id:  6,
  #                                 end_date:   Date.new(2014,2,22)) }

  it "should find challenges that expire tomorrow" do
    challenge1 = Challenge.create(end_date: Date.new(2014,2,22))
    challenge2 = Challenge.create(end_date: Date.new(2014,2,27))
    challenge3 = Challenge.create(end_date: Date.new(2014,2,22))

    expect(Reminder.expiring_bets).to eq([challenge1, challenge3])
  end


  it "should select the users that are participating in the challenges that expire tomorrow" do
    challenge1 = Challenge.create(challenger_id: 1, 
                                  challengee_id: 2, 
                                  end_date: Date.new(2014,2,22))
    challenge2 = Challenge.create(challenger_id: 3, 
                                  challengee_id: 4, 
                                  end_date: Date.new(2014,2,27))
    expect(Reminder.send_to).to eq({4=>[1, 2]})
  end

end