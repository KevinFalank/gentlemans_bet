require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "#addition" do
  	it "sample test" do
  		user = User.create(username: "kevin")

  		expect(user.add_2).to eq(4)

  	end
  end
  
end
