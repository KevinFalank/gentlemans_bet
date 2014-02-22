require 'spec_helper'

describe Challenge do
  describe "Challenge#obtain_bitly_url" do
    it "obtains a bitly url and saves it to the challenge record in the db" do
      challenge = Challenge.create(title: "title", terms: "terms", reward: "reward", end_date: "2014-02-22")
      challenge.obtain_bitly_url("http://127.0.0.1:3000")
      expect(challenge.bitly_url).to match(/bit/)
    end
  end
end
