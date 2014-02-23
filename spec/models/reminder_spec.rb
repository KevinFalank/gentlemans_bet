require 'spec_helper'

describe Reminder do

  it "should find challenges that expire tomorrow" do
    challenge1 = Challenge.create(end_date: (Date.today + 1))
    challenge2 = Challenge.create(end_date: (Date.today + 15))
    challenge3 = Challenge.create(end_date: (Date.today + 1))

    expect(Reminder.expiring_bets).to eq([challenge1, challenge3])
  end

end