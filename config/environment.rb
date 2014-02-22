# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
GentlemansBet::Application.initialize!

# Set up the twitter env variables
# APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
# env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))

# env_config.each do |key, value|
#   ENV[key] = value
# end

# environemtn variables are now set via Dotenv
Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
end
