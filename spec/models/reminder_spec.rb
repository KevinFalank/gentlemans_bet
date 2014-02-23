require 'spec_helper'

describe Reminder do

  it "should find challenges that expire tomorrow" do
    user = User.create(username: "Charlie")
    challenge1 = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user.id, status_id: 1, end_date: (Date.today + 1), reward: "A brilliant wizard's hat")
    challenge2 = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user.id, status_id: 1, end_date: (Date.today + 15), reward: "A brilliant wizard's hat")
    challenge3 = Challenge.create(title: "A manly bet", terms: "He who wins shall get to wear a big great grin", challenger_id: user.id, 
                  challengee_id: user.id, status_id: 1, end_date: (Date.today + 1), reward: "A brilliant wizard's hat")
    
    expect(Reminder.expiring_bets).to eq([challenge1, challenge3])
  end

end