require 'spec_helper'

describe Reminder do

	it "should check for challenges that expire tomorrow" do
    challenge1 = Challenge.create(end_date: Date.new(2014,2,22))
    challenge2 = Challenge.create(end_date: Date.new(2014,2,22))
    challenge3 = Challenge.create(end_date: Date.new(2014,2,27))

    expect(Challenge.expire_tomorrow).to eq([challenge1, challenge2])
  end

  pending "add some examples to (or delete) #{__FILE__}"
end