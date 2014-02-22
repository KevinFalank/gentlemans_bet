class Challenge < ActiveRecord::Base
	belongs_to :challenger, class_name: "User", foreign_key: "challenger_id"
	belongs_to :challengee, class_name: "User", foreign_key: "challengee_id"
	belongs_to :winner, class_name: "User", foreign_key: "winner_id"
	belongs_to :status

  def obtain_bitly_url(url)
    long_url = URI::encode(url)
    access_token = obtain_bitly_access_token
    request_to_bitly = URI.parse("https://api-ssl.bitly.com/v3/shorten?access_token=#{access_token}&longUrl=#{long_url}")
    bitly_response = Net::HTTP.get_response(request_to_bitly)
    self.bitly_url = JSON.parse(bitly_response.body)['data']['url']
    self.save
  end

  def update_winner(user)
    self.challenger == user ? self.winner_id = self.challengee.id : self.winner_id = self.challenger.id
    self.save
  end

  def issue
    "@"+self.challengee.username + ", You have been Challenged! " + self.title + ":" + self.bitly_url + " #gmbet"
  end

  def concede
    "@"+self.winner.username + ", Fine, I concede you are the greatest in the universe. " + self.title + ":" + self.bitly_url + " #gmbet"
  end

  private

  def obtain_bitly_access_token
    uri = URI.parse("https://api-ssl.bitly.com/oauth/access_token")
    req = Net::HTTP::Post.new(uri.path)
    req.basic_auth(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'])
    req.set_form_data({"grant_type" => "password", "username" => ENV['USERNAME'], "password" => ENV['PASSWORD']})
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.start {|http| http.request(req) }
    access_token = JSON.parse(response.body)["access_token"]
  end
end
