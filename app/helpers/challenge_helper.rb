require 'open-uri'
require 'net/http'
require 'openssl'
require 'dotenv'

def obtain_bitly_access_token
  uri = URI.parse("https://api-ssl.bitly.com/oauth/access_token")
  req = Net::HTTP::Post.new(uri.path)
  req.basic_auth(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'])
  # binding.pry
  req.set_form_data({"grant_type" => "password", "username" => ENV['USERNAME'], "password" => ENV['PASSWORD']})
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.start {|http| http.request(req) }
  access_token = JSON.parse(response.body)["access_token"]
end

def shorten_url_with_bitly(url, access_token)
  long_url = URI::encode(url)
  # access_token = obtain_access_token
  bitly_url = URI.parse("https://api-ssl.bitly.com/v3/shorten?access_token=#{access_token}&longUrl=#{long_url}")
  response = Net::HTTP.get_response(bitly_url)
  response_body = JSON.parse(response.body)
  short_url = response_body['data']['url']
end

